import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';
import 'package:smart_inventory/features/product/providers/product_controller.dart';
import 'package:smart_inventory/features/stock/data/stock_entry_model.dart';
import 'package:smart_inventory/features/stock/providers/stock_controller.dart';
import 'package:smart_inventory/shared/widgets/empty_state.dart';

// COMMIT 2: UI Development
class StockHistoryScreen extends ConsumerStatefulWidget {
  const StockHistoryScreen({super.key});

  @override
  ConsumerState<StockHistoryScreen> createState() => _StockHistoryScreenState();
}

class _StockHistoryScreenState extends ConsumerState<StockHistoryScreen> {
  String? _selectedProductId;

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(stockControllerProvider).valueOrNull ?? const <StockEntryModel>[];
    final products = ref.watch(productControllerProvider).valueOrNull ?? const <ProductModel>[];
    final filtered = _selectedProductId == null
        ? entries
        : entries.where((e) => e.productId == _selectedProductId).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Stock History')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(stockControllerProvider.notifier).reload(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String?>(
              value: _selectedProductId,
              decoration: const InputDecoration(labelText: 'Filter by Product'),
              items: [
                const DropdownMenuItem<String?>(value: null, child: Text('All Products')),
                ...products.map(
                  (p) => DropdownMenuItem<String?>(
                    value: p.id,
                    child: Text(p.name),
                  ),
                ),
              ],
              onChanged: (value) => setState(() => _selectedProductId = value),
            ),
            const SizedBox(height: 12),
            if (filtered.isEmpty)
              const EmptyState(
                title: 'No stock logs',
                message: 'Stock in/out entries will appear here.',
                icon: Icons.history,
              )
            else
              ...filtered.map((entry) {
                final isIn = entry.type == StockEntryType.stockIn;
                final color = isIn ? Colors.green : Colors.red;
                final symbol = isIn ? '+' : '-';
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.withAlpha(35),
                      child: Icon(isIn ? Icons.arrow_downward : Icons.arrow_upward, color: color),
                    ),
                    title: Text(entry.productName),
                    subtitle: Text(DateFormat('dd MMM yyyy, hh:mm a').format(entry.timestamp)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$symbol${entry.quantity}',
                          style: TextStyle(color: color, fontWeight: FontWeight.bold),
                        ),
                        if (entry.note.isNotEmpty)
                          Text(
                            entry.note,
                            style: const TextStyle(fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
