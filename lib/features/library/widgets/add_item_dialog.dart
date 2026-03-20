import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/library_item.dart';
import '../stores/library_store.dart';

class AddItemDialog extends ConsumerStatefulWidget {
  final String title;
  final String initialName;
  final double? initialPrice;
  final int initialQuantity;
  final String initialCategory;
  final Function(
    String name,
    double price,
    double quantity,
    String category,
    bool isTaxable,
    double discount,
  )
  onAdd;

  const AddItemDialog({
    super.key,
    this.title = 'Add Item',
    this.initialName = '',
    this.initialPrice,
    this.initialQuantity = 1,
    this.initialCategory = 'Uncategorized',
    required this.onAdd,
  });

  @override
  ConsumerState<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends ConsumerState<AddItemDialog> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _qtyController;
  late TextEditingController _discountController;
  late String _category;
  bool _isTaxable = true;
  bool _isPerWeight = false;

  String? _nameError;
  String? _priceError;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
    _nameController = TextEditingController(text: widget.initialName);
    _priceController = TextEditingController(
      text: widget.initialPrice?.toStringAsFixed(2) ?? '',
    );
    _qtyController = TextEditingController(
      text: widget.initialQuantity.toString(),
    );
    _discountController = TextEditingController(text: '0.00');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _qtyController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final name = _nameController.text.trim();
    final priceText = _priceController.text.trim();

    setState(() {
      _nameError = name.isEmpty ? 'Please enter a name' : null;
      _priceError = priceText.isEmpty ? 'Please enter a price' : null;
    });

    if (_nameError != null || _priceError != null) return;

    final price = double.tryParse(priceText) ?? 0.0;
    final qty = double.tryParse(_qtyController.text) ?? 1.0;
    final discount = double.tryParse(_discountController.text) ?? 0.0;

    final libraryNotifier = ref.read(libraryProvider.notifier);

    // Check if item exists in library with different data
    final existing = await libraryNotifier.findByName(name);

    if (existing != null &&
        (existing.price != price ||
            existing.category != _category ||
            existing.isPerWeight != _isPerWeight)) {
      if (!mounted) return;
      final shouldUpdate = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Update Library?'),
          content: Text(
            'This item is already in your library with different details:\n'
            'Library: \$${existing.price.toStringAsFixed(2)} (${existing.category})\n'
            'Current: \$${price.toStringAsFixed(2)} ($_category)\n\n'
            'Do you want to update your library with the new details?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Keep Existing'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Update Library'),
            ),
          ],
        ),
      );

      if (shouldUpdate == true) {
        await libraryNotifier.addToLibrary(
          name: name,
          price: price,
          category: _category,
          isPerWeight: _isPerWeight,
        );
      }
    } else {
      // New item or same details — addToLibrary handles both (refreshes if exists)
      await libraryNotifier.addToLibrary(
        name: name,
        price: price,
        category: _category,
        isPerWeight: _isPerWeight,
      );
    }

    final onAdd = widget.onAdd;
    if (mounted) Navigator.pop(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onAdd(name, price, qty, _category, _isTaxable, discount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Autocomplete<LibraryItem>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<LibraryItem>.empty();
                  }
                  return await ref
                      .read(libraryProvider.notifier)
                      .searchSuggestions(textEditingValue.text);
                },
                displayStringForOption: (LibraryItem option) => option.name,
                fieldViewBuilder:
                    (context, controller, focusNode, onFieldSubmitted) {
                      if (controller.text.isEmpty &&
                          _nameController.text.isNotEmpty) {
                        controller.text = _nameController.text;
                      }

                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onChanged: (val) {
                          _nameController.text = val;
                          if (_nameError != null) {
                            setState(() => _nameError = null);
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Item Name',
                          hintText: 'e.g. Fuji Apples',
                          prefixIcon: const Icon(Icons.shopping_bag_outlined),
                          errorText: _nameError,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      );
                    },
                onSelected: (LibraryItem selection) {
                  setState(() {
                    _nameController.text = selection.name;
                    _priceController.text = selection.price.toStringAsFixed(2);
                    _category = selection.category;
                    _isPerWeight = selection.isPerWeight;
                    _nameError = null;
                    _priceError = null;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _priceController,
                onChanged: (_) {
                  if (_priceError != null) setState(() => _priceError = null);
                },
                decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: const Icon(Icons.attach_money_rounded),
                  errorText: _priceError,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _qtyController,
                      decoration: InputDecoration(
                        labelText: _isPerWeight ? 'Weight' : 'Quantity',
                        hintText: '1.0',
                        suffixText: _isPerWeight ? 'kg' : 'pcs',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: _isPerWeight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        onTap: () =>
                            setState(() => _isPerWeight = !_isPerWeight),
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isPerWeight
                                  ? Icons.scale_rounded
                                  : Icons.numbers_rounded,
                              size: 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              _isPerWeight ? 'Kg/Lb' : 'Units',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _discountController,
                decoration: const InputDecoration(
                  labelText: 'Unit Discount',
                  prefixIcon: Icon(Icons.percent_rounded),
                  prefixText: '- \$',
                  hintText: '0.00',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                title: const Text(
                  'GCT Taxable',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: const Text(
                  'Tax applied to this item',
                  style: TextStyle(fontSize: 12),
                ),
                value: _isTaxable,
                onChanged: (val) => setState(() => _isTaxable = val),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _handleSubmit,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.add_rounded),
                label: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
