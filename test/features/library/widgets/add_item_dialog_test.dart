import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firstcheck/features/library/widgets/add_item_dialog.dart';
import 'package:firstcheck/features/library/stores/library_store.dart';
import 'package:firstcheck/features/library/models/library_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// We need a mock for the LibraryNotifier
class MockLibraryNotifier extends Notifier<LibraryState>
    implements LibraryNotifier {
  @override
  LibraryState build() => LibraryState.initial();

  @override
  Future<void> init() async {}

  @override
  Future<void> fetchItems() async {}

  @override
  Future<LibraryItem?> findByName(String name) async => null;

  @override
  Future<void> addToLibrary({
    required String name,
    required double price,
    String category = 'Uncategorized',
    bool isPerWeight = false,
  }) async {}

  @override
  Future<void> deleteItem(int id) async {}

  @override
  Future<List<LibraryItem>> searchSuggestions(String query) async => [];
  
  @override
  Future<String?> exportLibrary() {
    // TODO: implement exportLibrary
    throw UnimplementedError();
  }
  
  @override
  Future<String?> importLibrary() {
    // TODO: implement importLibrary
    throw UnimplementedError();
  }
}

void main() {
  // For these tests, we can just use a real Notifier with a ProviderScope override
  // or a simple manual mock if needed.

  Widget createTestWidget({
    Function(String, double, double, String, bool, double)? onAdd,
  }) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddItemDialog(
                      onAdd:
                          onAdd ??
                          (name, price, qty, category, isTaxable, discount) {},
                    ),
                  );
                },
                child: const Text('Open Dialog'),
              );
            },
          ),
        ),
      ),
    );
  }

  group('AddItemDialog Widget Tests', () {
    testWidgets('renders all input fields correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Tap button to show dialog
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      // Verify Title
      expect(find.text('Add Item'), findsOneWidget);

      // Verify TextFields exist (Name, Price, Qty, Discount)
      expect(find.byType(TextField), findsWidgets);

      // Verify specific labels exist
      expect(find.text('Item Name'), findsOneWidget);
      expect(find.text('Price'), findsOneWidget);
      expect(find.text('Quantity'), findsOneWidget);
      expect(find.text('Unit Package Discount'), findsOneWidget);

      // Verify Checkbox and Switch
      expect(find.text('By Weight'), findsOneWidget);
      expect(find.text('GCT Taxable'), findsOneWidget);
    });

    testWidgets('shows validation errors when fields are empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      // Tap on the 'Add' button to submit empty form
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Verify errors
      expect(find.text('Please enter a name'), findsOneWidget);
      expect(find.text('Please enter a price'), findsOneWidget);
    });

    testWidgets('triggers onAdd callback with correct data', (
      WidgetTester tester,
    ) async {
      bool callbackFired = false;
      String? returnedName;
      double? returnedPrice;
      double? returnedQty;
      String? returnedCategory;
      bool? returnedIsTaxable;
      double? returnedDiscount;

      await tester.pumpWidget(
        createTestWidget(
          onAdd: (name, price, qty, category, isTaxable, discount) {
            callbackFired = true;
            returnedName = name;
            returnedPrice = price;
            returnedQty = qty;
            returnedCategory = category;
            returnedIsTaxable = isTaxable;
            returnedDiscount = discount;
          },
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      // Enter data into TextFields

      // Target the text field inside Autocomplete by focusing on its label 'Item Name'
      await tester.enterText(
        find.widgetWithText(TextField, 'Item Name'),
        'Test Apple',
      );

      await tester.enterText(find.widgetWithText(TextField, 'Price'), '3.50');

      await tester.enterText(find.widgetWithText(TextField, 'Quantity'), '5');

      // Discount
      await tester.enterText(
        find.widgetWithText(TextField, 'Unit Package Discount'),
        '0.50',
      );

      // Toggle off 'GCT Taxable' SwitchListTile
      // The SwitchListTile is initially true, we tap it to make it false
      await tester.tap(find.widgetWithText(SwitchListTile, 'GCT Taxable'));
      await tester.pumpAndSettle();

      // Tap Add
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Verify callback triggered
      expect(callbackFired, isTrue);
      expect(returnedName, 'Test Apple');
      expect(returnedPrice, 3.50);
      expect(returnedQty, 5.0);
      expect(returnedDiscount, 0.50);
      expect(returnedIsTaxable, isFalse);
    });
  });
}
