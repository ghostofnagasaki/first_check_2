import 'package:flutter_test/flutter_test.dart';
import 'package:firstcheck/features/budget/stores/budget_store.dart';

void main() {
  group('BudgetState Unit Tests', () {
    test('initial state is correct', () {
      final state = BudgetState();
      expect(state.monthlyBudget, 0.0);
      expect(state.totalSpent, 0.0);
      expect(state.gctRate, 0.15);
      expect(state.remaining, 0.0);
      expect(state.spentPercentage, 0.0);
      expect(state.dailyBudget, 0.0);
      expect(state.isLowBalance, false);
    });

    test('calculates remaining budget correctly', () {
      final state = BudgetState(monthlyBudget: 1000.0, totalSpent: 200.0);
      expect(state.remaining, 800.0);
    });

    test('calculates spent percentage correctly', () {
      final state = BudgetState(monthlyBudget: 1000.0, totalSpent: 250.0);
      expect(state.spentPercentage, 0.25);
    });

    test('spent percentage maxes out at 1.0 (100%)', () {
      final state = BudgetState(monthlyBudget: 100.0, totalSpent: 150.0);
      expect(state.spentPercentage, 1.0); // Should clamp to 1.0
    });

    test('calculates daily budget correctly', () {
      final state = BudgetState(monthlyBudget: 3000.0);
      expect(state.dailyBudget, 100.0); // 3000 / 30
    });

    test('isLowBalance triggers when remaining is < 10% of budget', () {
      // 10% of 1000 = 100. Remaining must be < 100.

      // Edge case: Exactly 10% remaining (100)
      final stateBorderline = BudgetState(
        monthlyBudget: 1000.0,
        totalSpent: 900.0,
      );
      expect(stateBorderline.isLowBalance, isFalse);

      // Condition: < 10% remaining (90)
      final stateLow = BudgetState(monthlyBudget: 1000.0, totalSpent: 910.0);
      expect(stateLow.isLowBalance, isTrue);
    });

    test('copyWith updates fields correctly', () {
      final state = BudgetState();
      final updated = state.copyWith(
        monthlyBudget: 500.0,
        totalSpent: 50.0,
        gctRate: 0.10,
        activeListId: 'list1',
      );

      expect(updated.monthlyBudget, 500.0);
      expect(updated.totalSpent, 50.0);
      expect(updated.gctRate, 0.10);
      expect(updated.activeListId, 'list1');

      // Ensure originals are unchanged
      expect(state.monthlyBudget, 0.0);
    });
  });
}
