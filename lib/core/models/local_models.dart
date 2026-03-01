import 'package:isar/isar.dart';

part 'local_models.g.dart';

@collection
class BudgetInfo {
  Id id = 1; // Fixed ID for singleton record (1-based for Isar)

  double monthlyBudget = 0.0;
  double totalSpent = 0.0;
  double gctRate = 0.15; // Default 15%
  DateTime lastResetDate = DateTime.now();

  BudgetInfo();
}

@embedded
class CheckoutLineItem {
  late String name;
  late double unitPrice;
  late double quantity;
  String category = 'Uncategorized';
  bool isTaxable = true;
  bool isPerWeight = false;
  double unitDiscount = 0.0;

  CheckoutLineItem();

  CheckoutLineItem.create({
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.category,
    required this.isTaxable,
    required this.isPerWeight,
    required this.unitDiscount,
  });
}

@collection
class CheckoutTransaction {
  Id id = Isar.autoIncrement;

  late DateTime createdAt;
  String? storeName;

  List<CheckoutLineItem> items = [];

  double itemsSubtotal = 0.0;
  double totalDiscount = 0.0;
  double subtotal = 0.0;
  double taxableBase = 0.0;
  double gctRate = 0.15;
  double gct = 0.0;
  double finalTotal = 0.0;

  CheckoutTransaction();
}
