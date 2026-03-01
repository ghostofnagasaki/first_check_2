import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/library/models/library_item.dart';
import '../models/local_models.dart';

class LocalDbService {
  late Isar _isar;

  static final LocalDbService _instance = LocalDbService._internal();
  factory LocalDbService() => _instance;
  LocalDbService._internal();

  Future<void> init() async {
    final existing = Isar.getInstance();
    if (existing != null) {
      _isar = existing;
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      LibraryItemSchema,
      BudgetInfoSchema,
      CheckoutTransactionSchema,
    ], directory: dir.path);
  }

  Isar get isar => _isar;

  // CRUD for LibraryItem
  Future<List<LibraryItem>> getAllItems() async {
    return await _isar.libraryItems.where().sortByLastUsedAtDesc().findAll();
  }

  Future<LibraryItem?> findByName(String name) async {
    return await _isar.libraryItems
        .filter()
        .nameEqualTo(name, caseSensitive: false)
        .findFirst();
  }

  Future<void> saveItem(LibraryItem item) async {
    await _isar.writeTxn(() async {
      await _isar.libraryItems.put(item);
    });
  }

  Future<void> deleteItem(int id) async {
    await _isar.writeTxn(() async {
      await _isar.libraryItems.delete(id);
    });
  }

  Future<List<LibraryItem>> searchItems(String query) async {
    if (query.isEmpty) return [];
    return await _isar.libraryItems
        .filter()
        .nameContains(query, caseSensitive: false)
        .limit(10)
        .findAll();
  }
}
