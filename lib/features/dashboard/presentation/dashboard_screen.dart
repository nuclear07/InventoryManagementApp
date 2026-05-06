import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_inventory/core/connectivity_provider.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';
import 'package:smart_inventory/features/product/providers/product_controller.dart';
import 'package:smart_inventory/shared/widgets/empty_state.dart';
import 'package:smart_inventory/shared/widgets/stock_status_chip.dart';

// COMMIT 2: UI Development
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productControllerProvider);
    final summary = ref.watch(summaryProvider);
    final online = ref.watch(connectivityProvider).valueOrNull ?? true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Inventory'),
        actions: [
          Row(
            children: [
              Icon(online ? Icons.cloud_done : Icons.cloud_off),
              const SizedBox(width: 4),
              Text(online ? 'Online' : 'Offline'),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(productControllerProvider.notifier).reload(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (summary.low > 0 || summary.critical > 0)
              Card(
                color: summary.critical > 0
                    ? Colors.red.withAlpha(25)
                    : Colors.orange.withAlpha(25),
                child: ListTile(
                  leading: Icon(
                    summary.critical > 0 ? Icons.error : Icons.warning,
                    color: summary.critical > 0 ? Colors.red : Colors.orange,
                  ),
                  title: Text(
                    summary.critical > 0
                        ? '${summary.critical} product(s) are out of stock'
                        : '${summary.low} product(s) are low on stock',
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    label: 'Total Products',
                    value: '${summary.total}',
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryCard(
                    label: 'Low Stock',
                    value: '${summary.low}',
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryCard(
                    label: 'Out of Stock',
                    value: '${summary.critical}',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () => context.push('/stock-update'),
                  icon: const Icon(Icons.sync_alt),
                  label: const Text('Stock Update'),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.push('/stock-history'),
                  icon: const Icon(Icons.history),
                  label: const Text('History'),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.push('/search-filter'),
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Products', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            productsState.when(
              data: (products) {
                if (products.isEmpty) {
                  return const EmptyState(
                    title: 'No products yet',
                    message: 'Tap + to add your first product.',
                    icon: Icons.inventory_2_outlined,
                  );
                }
                final recently = [...products]
                  ..sort((a, b) => b.lastModified.compareTo(a.lastModified));

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...products.map(
                      (product) => Card(
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(
                            '${product.category.label} • Qty: ${product.quantityAvailable} • Min: ${product.minimumThreshold}',
                          ),
                          trailing: StockStatusChip(status: product.stockStatus),
                          onTap: () => context.push('/product-management?id=${product.id}'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Recently Updated',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ...recently.take(5).map(
                          (p) => ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(p.name),
                            subtitle: Text('Qty ${p.quantityAvailable}'),
                          ),
                        ),
                  ],
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, st) => Text('Error: $e'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/product-management'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(label, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
