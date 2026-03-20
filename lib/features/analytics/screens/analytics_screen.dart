import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:intl/intl.dart';
import '../../../core/models/local_models.dart';
import '../../../core/services/local_db_service.dart';
import '../../budget/stores/budget_store.dart';
import '../../cart/stores/cart_store.dart';

final checkoutTransactionsProvider = FutureProvider<List<CheckoutTransaction>>((
  ref,
) async {
  final isar = LocalDbService().isar;
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  return await isar.checkoutTransactions
      .filter()
      .createdAtGreaterThan(
        startOfMonth.subtract(const Duration(microseconds: 1)),
      )
      .sortByCreatedAtDesc()
      .findAll();
});

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetState = ref.watch(budgetProvider);
    final cartState = ref.watch(cartProvider);
    final txnsAsync = ref.watch(checkoutTransactionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Spending Analytics')),
      body: txnsAsync.when(
        data: (txns) =>
            _buildSummaryBody(context, budgetState, cartState, txns),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading analytics: $e')),
      ),
    );
  }

  Widget _buildSummaryBody(
    BuildContext context,
    BudgetState budgetState,
    CartState cartState,
    List<CheckoutTransaction> txns,
  ) {
    final budget = budgetState.monthlyBudget;
    final spent = txns.fold<double>(0.0, (sum, t) => sum + t.finalTotal);
    final saved = txns.fold<double>(0.0, (sum, t) => sum + t.totalDiscount);
    final inCart = cartState.finalTotal;
    final totalProjected = spent + inCart;
    final remaining = budget - totalProjected;

    final percentage = budget > 0
        ? (totalProjected / budget).clamp(0.0, 1.2)
        : 0.0;
    final isOver = totalProjected > budget;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Period',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            context,
            'Monthly Budget',
            '\$${budget.toStringAsFixed(2)}',
            Icons.account_balance_wallet_rounded,
            Theme.of(context).colorScheme.primary,
            isPrimary: true,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  'Total Spent',
                  '\$${spent.toStringAsFixed(2)}',
                  Icons.shopping_cart_rounded,
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Saved',
                  '\$${saved.toStringAsFixed(2)}',
                  Icons.local_offer_rounded,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  'Remaining',
                  '\$${remaining.abs().toStringAsFixed(2)}',
                  remaining >= 0
                      ? Icons.savings_rounded
                      : Icons.warning_rounded,
                  remaining >= 0
                      ? Colors.green
                      : Theme.of(context).colorScheme.error,
                  labelSuffix: remaining >= 0 ? '' : ' OVER',
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Budget Usage',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${(percentage * 100).toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: isOver
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 140,
                      width: 140,
                      child: CircularProgressIndicator(
                        value: percentage.clamp(0.0, 1.0),
                        strokeWidth: 12,
                        strokeCap: StrokeCap.round,
                        backgroundColor: Colors.grey.shade100,
                        color: isOver
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Column(
                      children: [
                        Icon(
                          isOver
                              ? Icons.trending_up_rounded
                              : Icons.trending_down_rounded,
                          color: isOver
                              ? Theme.of(context).colorScheme.error
                              : Colors.green,
                        ),
                        Text(
                          isOver ? 'Limit' : 'Pulse',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  isOver
                      ? 'You are \$${remaining.abs().toStringAsFixed(2)} over your limit!'
                      : 'You have \$${remaining.toStringAsFixed(2)} available for the rest of the month.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isOver
                        ? Theme.of(context).colorScheme.error
                        : Colors.grey.shade600,
                    fontWeight: isOver ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Recent Checkouts',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (txns.isEmpty)
            Text(
              'No checkouts yet this month.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          else
            Column(
              children: txns.take(8).map((t) {
                final dateLabel = DateFormat(
                  'MMM d, yyyy • h:mm a',
                ).format(t.createdAt);
                final store =
                    (t.storeName == null || t.storeName!.trim().isEmpty)
                    ? 'Unknown store'
                    : t.storeName!.trim();

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      store,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(dateLabel),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${t.finalTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        if (t.totalDiscount > 0)
                          Text(
                            'Saved \$${t.totalDiscount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color, {
    bool isPrimary = false,
    String labelSuffix = '',
  }) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isPrimary ? color.withValues(alpha: 0.2) : Colors.grey.shade200,
        ),
      ),
      color: isPrimary ? color.withValues(alpha: 0.05) : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              label + labelSuffix,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: isPrimary ? color : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
