import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../stores/budget_store.dart';

class BudgetAdjustDialog extends ConsumerStatefulWidget {
  const BudgetAdjustDialog({super.key});

  @override
  ConsumerState<BudgetAdjustDialog> createState() => _BudgetAdjustDialogState();
}

class _BudgetAdjustDialogState extends ConsumerState<BudgetAdjustDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    // Use Future.microtask or similar if ref is not ready?
    // Actually in ConsumerState, ref is available in initState as well.
    final budget = ref.read(budgetProvider).monthlyBudget;
    _controller.text = budget.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adjust Budget'),
      content: TextField(
        controller: _controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: 'Monthly Limit',
          prefixText: r'$',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final val = double.tryParse(_controller.text);
            if (val != null) {
              ref.read(budgetProvider.notifier).setBudget(val);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
