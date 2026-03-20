import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/screens/main_screen.dart';
import 'core/services/local_db_service.dart';

// Old stores - will be refactored to Riverpod
// import 'features/budget/stores/budget_store.dart';
// import 'features/library/stores/library_store.dart';
// import 'features/cart/stores/cart_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Database Service first
  final dbService = LocalDbService();
  await dbService.init();


  // await budgetStore.initialize();
  // await cartStore.init();
  // await libraryStore.init();

  runApp(const ProviderScope(child: FirstCheckApp()));
}

class FirstCheckApp extends StatelessWidget {
  const FirstCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FirstCheck',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}
