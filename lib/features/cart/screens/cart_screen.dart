import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/ocr_service.dart';
import '../../../core/services/local_db_service.dart';
import '../../cart/stores/cart_store.dart';
import '../../budget/stores/budget_store.dart';
import '../models/cart_item.dart';
import '../../library/widgets/add_item_dialog.dart';
import '../../../core/models/local_models.dart';

class CartScreen extends HookConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartItems = cartState.items;

    final budgetState = ref.watch(budgetProvider);

    // Use finalTotal (GCT-inclusive) for all budget comparisons
    final finalTotal = cartState.finalTotal;
    final projectedRemaining =
        budgetState.monthlyBudget - (budgetState.totalSpent + finalTotal);
    final isOverBudget = projectedRemaining < 0;

    final isFabExpanded = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              if (cartItems.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Cart?'),
                    content: const Text(
                      'Are you sure you want to remove all items?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(cartProvider.notifier).clearCart();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Premium Summary Card ─────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Card(
                elevation: 4, 
                shadowColor: isOverBudget
                    ? Theme.of(context).colorScheme.error.withValues(alpha: 0.2)
                    : Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    color: isOverBudget
                        ? Theme.of(context).colorScheme.error.withValues(alpha: 0.3)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isOverBudget
                          ? [
                              Theme.of(context).colorScheme.errorContainer,
                              Theme.of(context).colorScheme.surface,
                            ]
                          : [
                              Theme.of(
                                context,
                              ).colorScheme.primaryContainer.withValues(alpha: 0.9),
                              Theme.of(context).colorScheme.surface,
                            ],
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TOTAL SALES',
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                              Text(
                                '\$${finalTotal.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isOverBudget
                                          ? Theme.of(context).colorScheme.error
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isOverBudget
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.error.withValues(alpha: 0.1)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isOverBudget
                                  ? Icons.warning_rounded
                                  : Icons.account_balance_wallet_rounded,
                              color: isOverBudget
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.primary,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32, thickness: 1),
                      _ReceiptRow(
                        label: 'Items Subtotal',
                        value: cartState.itemsSubtotal,
                      ),
                      if (cartState.totalDiscount > 0)
                        _ReceiptRow(
                          label: 'Package Discount',
                          value: -cartState.totalDiscount,
                          valueColor: Colors.green.shade700,
                        ),
                      _ReceiptRow(
                        label:
                            'Tax (${(cartState.gctRate * 100).toStringAsFixed(0)}%)',
                        value: cartState.gct,
                        valueColor: Colors.orange.shade700,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isOverBudget
                                ? 'Over Budget By'
                                : 'Budget Remaining',
                            style: TextStyle(
                              color: isOverBudget
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '\$${projectedRemaining.abs().toStringAsFixed(2)}',
                            style: TextStyle(
                              color: isOverBudget
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Items List ────────────────────────────────────────────────
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 80,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Your cart is empty',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap the menu to add items or scan a receipt',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey[400]),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Dismissible(
                            key: Key(item.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              child: const Icon(
                                Icons.delete_sweep_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            onDismissed: (_) {
                              ref
                                  .read(cartProvider.notifier)
                                  .removeItem(item.id);
                            },
                            child: Card(
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    if (!item.isTaxable)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.blue.shade100,
                                          ),
                                        ),
                                        child: const Text(
                                          'TAX FREE',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    '${item.quantity % 1 == 0 ? item.quantity.toInt() : item.quantity.toStringAsFixed(2)}'
                                    '${item.isPerWeight ? ' kg' : ' pcs'} × \$${item.price.toStringAsFixed(2)}'
                                    '${item.discount > 0 ? '  −\$${item.discount.toStringAsFixed(2)} disc.' : ''}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$${item.total.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ── Budget Reset/Set FAB ──────────────────────────────────────
          FloatingActionButton(
            heroTag: 'budget_btn',
            onPressed: () => _showSetBudgetDialog(context, ref),
            mini: true,
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
            child: const Icon(Icons.edit_calendar),
          ),
          const SizedBox(height: 16),

          // ── Fanned Out Menu ──────────────────────────────────────────
          if (isFabExpanded.value) ...[
            FloatingActionButton.extended(
              heroTag: 'add_btn',
              onPressed: () {
                isFabExpanded.value = false;
                _showAddItemDialog(context, ref);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Item'),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              foregroundColor: Theme.of(
                context,
              ).colorScheme.onSecondaryContainer,
            ),
            const SizedBox(height: 8),
            FloatingActionButton.extended(
              heroTag: 'scan_btn',
              onPressed: () {
                isFabExpanded.value = false;
                _scanReceipt(context, ref);
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan Receipt'),
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              foregroundColor: Theme.of(
                context,
              ).colorScheme.onTertiaryContainer,
            ),
            const SizedBox(height: 8),
            FloatingActionButton.extended(
              heroTag: 'checkout_btn',
              onPressed: () {
                isFabExpanded.value = false;
                _checkoutCart(context, ref, cartItems, cartState.finalTotal);
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Checkout'),
              backgroundColor: Colors.green.shade100,
              foregroundColor: Colors.green.shade900,
            ),
            const SizedBox(height: 12),
          ],

          FloatingActionButton(
            heroTag: 'menu_btn',
            onPressed: () => isFabExpanded.value = !isFabExpanded.value,
            backgroundColor: isFabExpanded.value
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : Theme.of(context).colorScheme.primary,
            foregroundColor: isFabExpanded.value
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onPrimary,
            child: Icon(isFabExpanded.value ? Icons.close : Icons.menu),
          ),
        ],
      ),
    );
  }

  Future<void> _checkoutCart(
    BuildContext context,
    WidgetRef ref,
    List<CartItem> items,
    double finalTotal,
  ) async {
    if (items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cart is empty!')));
      return;
    }

    final storeController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Checkout'),
        content: TextField(
          controller: storeController,
          decoration: const InputDecoration(
            labelText: 'Store Name (Optional)',
            hintText: 'e.g. Shopper\'s Fair',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);

              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Saving cart...')));

              try {
                final cartState = ref.read(cartProvider);
                final storeName = storeController.text.trim().isEmpty
                    ? null
                    : storeController.text.trim();

                final txn = CheckoutTransaction()
                  ..createdAt = DateTime.now()
                  ..storeName = storeName
                  ..items = items
                      .map(
                        (e) => CheckoutLineItem.create(
                          name: e.name,
                          unitPrice: e.price,
                          quantity: e.quantity,
                          category: e.category,
                          isTaxable: e.isTaxable,
                          isPerWeight: e.isPerWeight,
                          unitDiscount: e.discount,
                        ),
                      )
                      .toList()
                  ..itemsSubtotal = cartState.itemsSubtotal
                  ..totalDiscount = cartState.totalDiscount
                  ..subtotal = cartState.subtotal
                  ..taxableBase = cartState.taxableBase
                  ..gctRate = cartState.gctRate
                  ..gct = cartState.gct
                  ..finalTotal = cartState.finalTotal;

                final isar = LocalDbService().isar;
                await isar.writeTxn(() async {
                  await isar.checkoutTransactions.put(txn);
                });

                // Deduct GCT-inclusive total from budget
                await ref.read(budgetProvider.notifier).addToSpent(finalTotal);

                ref.read(cartProvider.notifier).clearCart();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Purchase completed!')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating budget: $e')),
                  );
                }
              }
            },
            child: const Text('Save & Finish'),
          ),
        ],
      ),
    );
  }

  Future<void> _scanReceipt(BuildContext context, WidgetRef ref) async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(source: ImageSource.camera);

    if (photo == null) return;

    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final ocrService = OcrService();
      final items = await ocrService.parseReceipt(File(photo.path));

      if (!context.mounted) return;
      Navigator.pop(context);

      if (items.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No items detected. Try manually adding.'),
          ),
        );
        return;
      }

      _showParsedItemsDialog(context, ref, items);
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error scanning receipt: $e')));
    }
  }

  void _showParsedItemsDialog(
    BuildContext context,
    WidgetRef ref,
    List<CartItem> items,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return HookBuilder(
          builder: (context) {
            final selectedIndices = useState(
              List.generate(items.length, (i) => true),
            );

            final selectedCount = selectedIndices.value
                .where((selected) => selected)
                .length;

            return AlertDialog(
              title: Text('Found ${items.length} Items'),
              content: SizedBox(
                width: double.maxFinite,
                height: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Uncheck items you do not want to add:',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return CheckboxListTile(
                            value: selectedIndices.value[index],
                            title: Text(item.name),
                            subtitle: Text(
                              '\$${item.price.toStringAsFixed(2)}',
                            ),
                            onChanged: (val) {
                              final newList = [...selectedIndices.value];
                              newList[index] = val ?? false;
                              selectedIndices.value = newList;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: selectedCount == 0
                      ? null
                      : () {
                          for (int i = 0; i < items.length; i++) {
                            if (selectedIndices.value[i]) {
                              final item = items[i];
                              ref
                                  .read(cartProvider.notifier)
                                  .addItem(
                                    item.name,
                                    item.price,
                                    item.quantity,
                                    isTaxable: item.isTaxable,
                                    isPerWeight: item.isPerWeight,
                                    discount: item.discount,
                                  );
                            }
                          }
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added $selectedCount items!'),
                            ),
                          );
                        },
                  child: Text('Add ($selectedCount)'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddItemDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(
        onAdd: (name, price, qty, category, isTaxable, discount) {
          _addItemWithBudgetCheck(
            context,
            ref,
            name,
            price,
            qty,
            isTaxable: isTaxable,
            discount: discount,
          );
        },
      ),
    );
  }

  void _addItemWithBudgetCheck(
    BuildContext context,
    WidgetRef ref,
    String name,
    double price,
    double qty, {
    bool isTaxable = true,
    bool isPerWeight = false,
    double discount = 0.0,
  }) {
    // Compute projected finalTotal if this item were added
    final currentState = ref.read(cartProvider);
    final budgetState = ref.read(budgetProvider);

    final itemNet = (price * qty) - discount;
    final itemGct = isTaxable ? itemNet * currentState.gctRate : 0.0;
    final projectedFinalTotal = currentState.finalTotal + itemNet + itemGct;

    final budget = budgetState.monthlyBudget;

    if (budget > 0 && (budgetState.totalSpent + projectedFinalTotal) > budget) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('⚠️ Budget Alert'),
          content: Text(
            'Adding this item will exceed your monthly budget of '
            '\$${budget.toStringAsFixed(2)}.\n\n'
            'Projected Total (incl. GCT): '
            '\$${(budgetState.totalSpent + projectedFinalTotal).toStringAsFixed(2)}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .addItem(
                      name,
                      price,
                      qty,
                      isTaxable: isTaxable,
                      isPerWeight: isPerWeight,
                      discount: discount,
                    );
                Navigator.pop(context);
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Add Anyway'),
            ),
          ],
        ),
      );
    } else {
      ref
          .read(cartProvider.notifier)
          .addItem(
            name,
            price,
            qty,
            isTaxable: isTaxable,
            isPerWeight: isPerWeight,
            discount: discount,
          );
    }
  }

  Future<void> _showSetBudgetDialog(BuildContext context, WidgetRef ref) async {
    final budgetState = ref.read(budgetProvider);
    final cartState = ref.read(cartProvider);

    final budgetController = TextEditingController(
      text: budgetState.monthlyBudget.toStringAsFixed(0),
    );
    final gctController = TextEditingController(
      text: (cartState.gctRate * 100).toStringAsFixed(0),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Budget & Tax Settings'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Monthly Budget (\$)',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: gctController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'GCT Tax Rate (%)',
                  suffixText: '%',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(budgetProvider.notifier).resetSpent();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Spending total reset!')),
              );
            },
            child: const Text(
              'Reset Spent',
              style: TextStyle(color: Colors.red),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final budget = double.tryParse(budgetController.text) ?? 0.0;
              final gct = (double.tryParse(gctController.text) ?? 0.0) / 100.0;

              await ref.read(budgetProvider.notifier).setBudget(budget);
              await ref.read(budgetProvider.notifier).setGctRate(gct);
              ref.read(cartProvider.notifier).setGctRate(gct);

              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings updated!')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// ── Helper widget ────────────────────────────────────────────────────────────

class _ReceiptRow extends StatelessWidget {
  final String label;
  final double value;
  final Color? valueColor;

  const _ReceiptRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final sign = value < 0 ? '-' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            '$sign\$${value.abs().toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
