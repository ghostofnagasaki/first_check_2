import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/local_db_service.dart';
import '../models/library_item.dart';

class LibraryState {
  final List<LibraryItem> items;
  final bool isLoading;
  final String? error;

  LibraryState({required this.items, this.isLoading = false, this.error});

  factory LibraryState.initial() => LibraryState(items: []);

  LibraryState copyWith({
    List<LibraryItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return LibraryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class LibraryNotifier extends Notifier<LibraryState> {
  final _dbService = LocalDbService();

  @override
  LibraryState build() {
    Future.microtask(init);
    return LibraryState.initial();
  }

  Future<void> init() async {
    await _dbService.init();
    await fetchItems();
  }

  Future<void> fetchItems() async {
    state = state.copyWith(isLoading: true);
    try {
      final items = await _dbService.getAllItems();
      state = state.copyWith(items: List.unmodifiable(items), isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<LibraryItem?> findByName(String name) async {
    return await _dbService.findByName(name);
  }

  Future<void> addToLibrary({
    required String name,
    required double price,
    String category = 'Uncategorized',
    bool isPerWeight = false,
  }) async {
    final existing = await _dbService.findByName(name);

    LibraryItem item;

    if (existing != null) {
      item = existing.copyWith(
        price: price,
        category: category,
        isPerWeight: isPerWeight,
        lastUsedAt: DateTime.now(),
      );

      // Add to price history if price changed
      if (existing.price != price) {
        item.priceHistory = [
          ...item.priceHistory,
          PriceHistoryEntry.create(date: DateTime.now(), price: price),
        ];
      }
    } else {
      item = LibraryItem.create(
        name: name,
        price: price,
        category: category,
        isPerWeight: isPerWeight,
      );
    }

    await _dbService.saveItem(item);
    await fetchItems();
  }

  Future<void> deleteItem(int id) async {
    await _dbService.deleteItem(id);
    await fetchItems();
  }

  Future<List<LibraryItem>> searchSuggestions(String query) async {
    return await _dbService.searchItems(query);
  }
}

final libraryProvider = NotifierProvider<LibraryNotifier, LibraryState>(
  () => LibraryNotifier(),
);
