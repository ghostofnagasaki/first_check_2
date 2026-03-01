import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/local_db_service.dart';
import '../../../core/models/local_models.dart';

class BudgetState {
  final double monthlyBudget;
  final double totalSpent;
  final double gctRate;
  final String? activeListId;

  BudgetState({
    this.monthlyBudget = 0.0,
    this.totalSpent = 0.0,
    this.gctRate = 0.15,
    this.activeListId,
  });

  double get remaining => monthlyBudget - totalSpent;
  double get spentPercentage =>
      monthlyBudget > 0 ? (totalSpent / monthlyBudget).clamp(0.0, 1.0) : 0.0;
  double get dailyBudget => monthlyBudget / 30;
  bool get isLowBalance => remaining < (monthlyBudget * 0.1);

  BudgetState copyWith({
    double? monthlyBudget,
    double? totalSpent,
    double? gctRate,
    String? activeListId,
  }) {
    return BudgetState(
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      totalSpent: totalSpent ?? this.totalSpent,
      gctRate: gctRate ?? this.gctRate,
      activeListId: activeListId ?? this.activeListId,
    );
  }
}

class BudgetNotifier extends Notifier<BudgetState> {
  final _db = LocalDbService();

  @override
  BudgetState build() {
    // Fire off async initialization when the provider is first created
    Future.microtask(initialize);
    return BudgetState();
  }

  Future<void> initialize() async {
    final isar = _db.isar;
    final info = await isar.budgetInfos.get(1);
    if (info != null) {
      state = state.copyWith(
        monthlyBudget: info.monthlyBudget,
        totalSpent: info.totalSpent,
        gctRate: info.gctRate,
      );
    } else {
      // Initialize with default if absolutely missing
      await isar.writeTxn(() async {
        await isar.budgetInfos.put(BudgetInfo());
      });
    }
  }

  Future<void> setBudget(double amount) async {
    final isar = _db.isar;
    await isar.writeTxn(() async {
      final info = await isar.budgetInfos.get(1) ?? BudgetInfo();
      info.monthlyBudget = amount;
      await isar.budgetInfos.put(info);
    });
    state = state.copyWith(monthlyBudget: amount);
  }

  Future<void> addToSpent(double amount) async {
    final isar = _db.isar;
    final newSpent = state.totalSpent + amount;
    await isar.writeTxn(() async {
      final info = await isar.budgetInfos.get(1) ?? BudgetInfo();
      info.totalSpent = newSpent;
      await isar.budgetInfos.put(info);
    });
    state = state.copyWith(totalSpent: newSpent);
  }

  Future<void> resetSpent() async {
    final isar = _db.isar;
    await isar.writeTxn(() async {
      final info = await isar.budgetInfos.get(1) ?? BudgetInfo();
      info.totalSpent = 0;
      info.lastResetDate = DateTime.now();
      await isar.budgetInfos.put(info);
    });
    state = state.copyWith(totalSpent: 0);
  }

  Future<void> setGctRate(double rate) async {
    final isar = _db.isar;
    await isar.writeTxn(() async {
      final info = await isar.budgetInfos.get(1) ?? BudgetInfo();
      info.gctRate = rate;
      await isar.budgetInfos.put(info);
    });
    state = state.copyWith(gctRate: rate);
  }
}

final budgetProvider = NotifierProvider<BudgetNotifier, BudgetState>(
  () => BudgetNotifier(),
);
