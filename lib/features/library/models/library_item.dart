import 'package:isar/isar.dart';

part 'library_item.g.dart';

@embedded
class PriceHistoryEntry {
  late DateTime date;
  late double price;

  PriceHistoryEntry();

  PriceHistoryEntry.create({required this.date, required this.price});
}

@collection
class LibraryItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String name;

  late double price;

  bool isPerWeight = false;

  String category = 'Uncategorized';

  late DateTime lastUsedAt;

  List<PriceHistoryEntry> priceHistory = [];

  LibraryItem();

  LibraryItem.create({
    required this.name,
    required this.price,
    this.category = 'Uncategorized',
    this.isPerWeight = false,
    DateTime? lastUsedAt,
    List<PriceHistoryEntry>? priceHistory,
  }) {
    this.lastUsedAt = lastUsedAt ?? DateTime.now();
    this.priceHistory =
        priceHistory ??
        [PriceHistoryEntry.create(date: this.lastUsedAt, price: price)];
  }

  LibraryItem copyWith({
    String? name,
    double? price,
    String? category,
    bool? isPerWeight,
    DateTime? lastUsedAt,
    List<PriceHistoryEntry>? priceHistory,
  }) {
    return LibraryItem()
      ..id = id
      ..name = name ?? this.name
      ..price = price ?? this.price
      ..category = category ?? this.category
      ..isPerWeight = isPerWeight ?? this.isPerWeight
      ..lastUsedAt = lastUsedAt ?? this.lastUsedAt
      ..priceHistory = priceHistory ?? this.priceHistory;
  }
}
