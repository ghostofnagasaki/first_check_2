import 'package:isar/isar.dart';

part 'library_item.g.dart';

@embedded
class PriceHistoryEntry {
  late DateTime date;
  late double price;

  PriceHistoryEntry();

  PriceHistoryEntry.create({required this.date, required this.price});

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'price': price,
      };

  factory PriceHistoryEntry.fromJson(Map<String, dynamic> json) {
    return PriceHistoryEntry.create(
      date: DateTime.parse(json['date'] as String),
      price: (json['price'] as num).toDouble(),
    );
  }
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

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'isPerWeight': isPerWeight,
        'category': category,
        'lastUsedAt': lastUsedAt.toIso8601String(),
        'priceHistory': priceHistory.map((e) => e.toJson()).toList(),
      };

  factory LibraryItem.fromJson(Map<String, dynamic> json) {
    final item = LibraryItem.create(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: (json['category'] as String?) ?? 'Uncategorized',
      isPerWeight: (json['isPerWeight'] as bool?) ?? false,
      lastUsedAt: json['lastUsedAt'] != null
          ? DateTime.parse(json['lastUsedAt'] as String)
          : null,
      priceHistory: json['priceHistory'] != null
          ? (json['priceHistory'] as List)
              .map((e) => PriceHistoryEntry.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
    return item;
  }
}
