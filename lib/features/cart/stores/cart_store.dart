import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/local_db_service.dart';
import '../../../core/models/local_models.dart';
import '../models/cart_item.dart';

class CartState {
  final List<CartItem> items;
  final double gctRate;

  CartState({required this.items, this.gctRate = 0.15});

  factory CartState.initial() {
    return CartState(items: []);
  }

  int get itemCount => items.length;

  /// Σ (price × qty) — raw sum before any discounts.
  double get itemsSubtotal =>
      items.fold(0.0, (sum, item) => sum + item.rawTotal);

  /// Total of all per-item discounts (unit discount × qty).
  double get totalDiscount =>
      items.fold(0.0, (sum, item) => sum + (item.discount * item.quantity));

  /// Subtotal after discounts, before GCT.
  double get subtotal => itemsSubtotal - totalDiscount;

  /// The portion of subtotal that GCT applies to (taxable items only).
  double get taxableBase =>
      items.fold(0.0, (sum, item) => item.isTaxable ? sum + item.total : sum);

  /// GCT applied to the taxable base using the configurable rate.
  double get gct => taxableBase * gctRate;

  /// *** TOTAL SALES *** — the real amount that leaves your wallet.
  double get finalTotal => subtotal + gct;

  // Legacy alias
  double get total => finalTotal;

  CartState copyWith({List<CartItem>? items, double? gctRate}) {
    return CartState(
      items: items ?? this.items,
      gctRate: gctRate ?? this.gctRate,
    );
  }
}

class CartNotifier extends Notifier<CartState> {
  @override
  CartState build() {
    // Initialization can happen here if it's synchronous,
    // or triggered via microtask if it depends on async services.
    Future.microtask(init);
    return CartState.initial();
  }

  Future<void> init() async {
    final isar = LocalDbService().isar;
    final info = await isar.budgetInfos.get(1);
    if (info != null) {
      state = state.copyWith(gctRate: info.gctRate);
    }
  }

  void setGctRate(double rate) {
    state = state.copyWith(gctRate: rate);
  }

  void addItem(
    String name,
    double price,
    double quantity, {
    String category = 'Uncategorized',
    bool isTaxable = true,
    bool isPerWeight = false,
    double discount = 0.0,
  }) {
    final newItem = CartItem.create(
      name: name,
      price: price,
      quantity: quantity,
      category: category,
      isTaxable: isTaxable,
      isPerWeight: isPerWeight,
      discount: discount,
    );

    final updatedItems = [...state.items, newItem];
    state = state.copyWith(items: updatedItems);
  }

  void removeItem(String id) {
    final updatedItems = state.items.where((item) => item.id != id).toList();
    state = state.copyWith(items: updatedItems);
  }

  void clearCart() {
    state = state.copyWith(items: []);
  }
}

final cartProvider = NotifierProvider<CartNotifier, CartState>(() {
  return CartNotifier();
});
