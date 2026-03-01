import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final double quantity;
  final String category;

  /// Whether GCT applies to this item.
  final bool isTaxable;

  /// Whether the item is sold by weight (allows decimal qty).
  final bool isPerWeight;

  /// Per-item package / bulk discount amount (absolute $, not %).
  final double discount;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.category = 'Uncategorized',
    this.isTaxable = true,
    this.isPerWeight = false,
    this.discount = 0.0,
  });

  /// Line total BEFORE GCT, AFTER unit discount.
  double get total => (price - discount) * quantity;

  /// Raw line total with no discount applied (for subtotal display).
  double get rawTotal => price * quantity;

  factory CartItem.create({
    required String name,
    required double price,
    double quantity = 1,
    String category = 'Uncategorized',
    bool isTaxable = true,
    bool isPerWeight = false,
    double discount = 0.0,
  }) {
    return CartItem(
      id: const Uuid().v4(),
      name: name,
      price: price,
      quantity: quantity,
      category: category,
      isTaxable: isTaxable,
      isPerWeight: isPerWeight,
      discount: discount,
    );
  }

  CartItem copyWith({
    String? id,
    String? name,
    double? price,
    double? quantity,
    String? category,
    bool? isTaxable,
    bool? isPerWeight,
    double? discount,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      isTaxable: isTaxable ?? this.isTaxable,
      isPerWeight: isPerWeight ?? this.isPerWeight,
      discount: discount ?? this.discount,
    );
  }
}
