import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';
import 'package:smart_inventory/features/product/providers/product_controller.dart';
import 'package:smart_inventory/shared/widgets/empty_state.dart';
import 'package:smart_inventory/shared/widgets/stock_status_chip.dart';

// COMMIT 2: UI Development
class SearchFilterScreen extends ConsumerStatefulWidget {
  const SearchFilterScreen({super.key});

  @override
  ConsumerState<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends ConsumerState<SearchFilterScreen> {
  final _searchController = TextEditingController();
  ProductCategory? _category;
  StockStatus? _status;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productControllerProvider).valueOrNull ?? const <ProductModel>[];
    final query = _searchController.text.trim().toLowerCase();

    final filtered = products.where((product) {
      final byName = query.isEmpty || product.name.toLowerCase().contains(query);
      final byCategory = _category == null || product.category == _category;
      final byStatus = _status == null || product.stockStatus == _status;
      return byName && byCategory && byStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Search & Filter')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'Search products',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 12),
          Text('Category', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: _category == null,
                onSelected: (_) => setState(() => _category = null),
              ),
              ...ProductCategory.values.map(
                (c) => ChoiceChip(
                  label: Text(c.label),
                  selected: _category == c,
                  onSelected: (_) => setState(() => _category = c),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Stock Status', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: _status == null,
                onSelected: (_) => setState(() => _status = null),
              ),
              ...StockStatus.values.map(
                (s) => ChoiceChip(
                  label: Text(s.name[0].toUpperCase() + s.name.substring(1)),
                  selected: _status == s,
                  onSelected: (_) => setState(() => _status = s),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (filtered.isEmpty)
            const EmptyState(
              title: 'No results',
              message: 'Try changing search text or filters.',
              icon: Icons.search_off,
            )
          else
            ...filtered.map(
              (product) => Card(
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text(
                    '${product.category.label} • Qty ${product.quantityAvailable}',
                  ),
                  trailing: StockStatusChip(status: product.stockStatus),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
