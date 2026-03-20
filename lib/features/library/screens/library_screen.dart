import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../stores/library_store.dart';
import '../widgets/add_item_dialog.dart';
import 'item_analytics_screen.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(libraryProvider);
    final items = state.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Library'),
        actions: [
          IconButton(
            onPressed: () {}, // Could add search here later
            icon: const Icon(Icons.search_rounded),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) async {
              if (value == 'export') {
                final message = await ref.read(libraryProvider.notifier).exportLibrary();
                if (message != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                }
              } else if (value == 'import') {
                final message = await ref.read(libraryProvider.notifier).importLibrary();
                if (message != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.upload_file_rounded, size: 20),
                    SizedBox(width: 8),
                    Text('Export Library'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'import',
                child: Row(
                  children: [
                    Icon(Icons.download_rounded, size: 20),
                    SizedBox(width: 8),
                    Text('Import Library'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your library is empty',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Add items from the cart to see them here!'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child: Text(
                        item.name[0].toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '\$${item.price.toStringAsFixed(2)} • ${item.category}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.analytics_rounded, size: 20),
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () => _showAnalyticsDialog(context, item),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert_rounded),
                          onSelected: (value) {
                            if (value == 'edit') {
                              _showEditDialog(context, ref, item);
                            } else if (value == 'delete') {
                              ref
                                  .read(libraryProvider.notifier)
                                  .deleteItem(item.id);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit_rounded, size: 18),
                                  SizedBox(width: 8),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_rounded,
                                    size: 18,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Delete'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Item'),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    await showDialog(
      context: context,
      builder: (context) => AddItemDialog(
        onAdd: (name, price, qty, category, isTaxable, discount) {
          // Already handled by AddItemDialog for library
        },
      ),
    );
  }

  void _showAnalyticsDialog(BuildContext context, dynamic item) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ItemAnalyticsScreen(item: item)),
    );
  }

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    dynamic item,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AddItemDialog(
        title: 'Edit Item',
        initialName: item.name,
        initialPrice: item.price,
        initialCategory: item.category,
        onAdd: (name, price, qty, category, isTaxable, discount) {
          // Edits are handled by the same logic in AddItemDialog
        },
      ),
    );
  }
}
