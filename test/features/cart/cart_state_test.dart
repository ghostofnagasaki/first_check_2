import 'package:flutter_test/flutter_test.dart';
import 'package:firstcheck/features/cart/stores/cart_store.dart';
import 'package:firstcheck/features/cart/models/cart_item.dart';

void main() {
  group('CartState Unit Tests', () {
    test('initial state is correct', () {
      final state = CartState.initial();
      expect(state.items, isEmpty);
      expect(state.gctRate, 0.15);
      expect(state.itemCount, 0);
      expect(state.itemsSubtotal, 0.0);
      expect(state.totalDiscount, 0.0);
      expect(state.subtotal, 0.0);
      expect(state.taxableBase, 0.0);
      expect(state.gct, 0.0);
      expect(state.finalTotal, 0.0);
    });

    test('adds non-taxable item and calculates totals correctly', () {
      final item = CartItem.create(
        name: 'Apple',
        price: 2.0,
        quantity: 3,
        isTaxable: false,
      );

      final state = CartState(items: [item]);

      expect(state.itemCount, 1);
      expect(state.itemsSubtotal, 6.0); // 2.0 * 3
      expect(state.totalDiscount, 0.0);
      expect(state.subtotal, 6.0);
      expect(state.taxableBase, 0.0); // Non-taxable
      expect(state.gct, 0.0);
      expect(state.finalTotal, 6.0);
    });

    test('adds taxable item and calculates GCT correctly', () {
      final item = CartItem.create(
        name: 'Soda',
        price: 1.0,
        quantity: 5,
        isTaxable: true,
      );

      final state = CartState(items: [item], gctRate: 0.15);

      expect(state.itemCount, 1);
      expect(state.itemsSubtotal, 5.0);
      expect(state.taxableBase, 5.0);
      expect(state.gct, 0.75); // 5.0 * 0.15
      expect(state.finalTotal, 5.75); // 5.0 + 0.75
    });

    test('calculates correct totals with discounts', () {
      final item = CartItem.create(
        name: 'Bread',
        price: 4.0,
        quantity: 2,
        isTaxable: true,
        discount: 1.0, // $1 discount per item
      );

      final state = CartState(items: [item], gctRate: 0.10);

      expect(state.itemsSubtotal, closeTo(8.0, 0.01)); // 4.0 * 2
      expect(state.totalDiscount, closeTo(2.0, 0.01)); // 1.0 * 2
      expect(state.subtotal, closeTo(6.0, 0.01)); // 8.0 - 2.0
      expect(
        state.taxableBase,
        closeTo(6.0, 0.01),
      ); // Tax applies to discounted subtotal
      expect(state.gct, closeTo(0.60, 0.01)); // 6.0 * 0.10
      expect(state.finalTotal, closeTo(6.60, 0.01)); // 6.0 + 0.60
    });

    test('calculates totals with mixed items (taxable vs exempt)', () {
      final exemptItem = CartItem.create(
        name: 'Water',
        price: 2.0,
        quantity: 1,
        isTaxable: false,
      );

      final taxableItem = CartItem.create(
        name: 'Cake',
        price: 10.0,
        quantity: 1,
        isTaxable: true,
        discount: 2.0,
      );

      final state = CartState(items: [exemptItem, taxableItem], gctRate: 0.15);

      expect(state.itemCount, 2);
      expect(state.itemsSubtotal, closeTo(12.0, 0.01)); // 2.0 + 10.0
      expect(state.totalDiscount, closeTo(2.0, 0.01)); // Discount only on Cake
      expect(state.subtotal, closeTo(10.0, 0.01)); // 12.0 - 2.0
      expect(state.taxableBase, closeTo(8.0, 0.01)); // (10 - 2)
      expect(state.gct, closeTo(1.20, 0.01)); // 8.0 * 0.15
      expect(
        state.finalTotal,
        closeTo(11.20, 0.01),
      ); // 10.0 subtotal + 1.20 tax
    });
  });
}
