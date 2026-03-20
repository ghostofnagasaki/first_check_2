import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

  Future<String?> exportLibrary() async {
    try {
      final items = await _dbService.getAllItems();
      final jsonString = jsonEncode(items.map((e) => e.toJson()).toList());

      final outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Export Library',
        fileName: 'firstcheck_library_backup.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsString(jsonString);
        return 'Library exported successfully to $outputFile';
      }
      return null;
    } catch (e) {
      return 'Failed to export library: $e';
    }
  }

  Future<String?> importLibrary() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Import Library Backup',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        
        final List<LibraryItem> importedItems = jsonList.map((e) => LibraryItem.fromJson(e)).toList();
        
        await _dbService.importItems(importedItems);
        await fetchItems();
        return 'Successfully imported ${importedItems.length} items.';
      }
      return null; // User canceled
    } catch (e) {
      return 'Failed to import library: $e';
    }
  }
}

final libraryProvider = NotifierProvider<LibraryNotifier, LibraryState>(
  () => LibraryNotifier(),
);
