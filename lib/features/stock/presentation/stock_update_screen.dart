import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';
import 'package:smart_inventory/features/product/providers/product_controller.dart';
import 'package:smart_inventory/features/stock/data/stock_entry_model.dart';
import 'package:smart_inventory/features/stock/providers/stock_controller.dart';

// COMMIT 2: UI Development
class StockUpdateScreen extends ConsumerStatefulWidget {
  const StockUpdateScreen({super.key});

  @override
  ConsumerState<StockUpdateScreen> createState() => _StockUpdateScreenState();
}

class _StockUpdateScreenState extends ConsumerState<StockUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _noteController = TextEditingController();
  String? _productId;
  StockEntryType _type = StockEntryType.stockIn;

  @override
  void dispose() {
    _quantityController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productControllerProvider).valueOrNull ?? const <ProductModel>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Stock Update')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              value: _productId,
              decoration: const InputDecoration(labelText: 'Product'),
              items: products
                  .map(
                    (p) => DropdownMenuItem<String>(
                      value: p.id,
                      child: Text('${p.name} (Qty: ${p.quantityAvailable})'),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _productId = value),
              validator: (value) => value == null ? 'Select a product.' : null,
            ),
            const SizedBox(height: 12),
            SegmentedButton<StockEntryType>(
              segments: const [
                ButtonSegment(
                  value: StockEntryType.stockIn,
                  label: Text('Stock In'),
                  icon: Icon(Icons.add),
                ),
                ButtonSegment(
                  value: StockEntryType.stockOut,
                  label: Text('Stock Out'),
                  icon: Icon(Icons.remove),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (value) => setState(() => _type = value.first),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'Quantity is required.';
                final parsed = int.tryParse(value);
                if (parsed == null || parsed <= 0) return 'Enter a value greater than 0.';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Note (Optional)'),
              minLines: 2,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Submit'),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm stock update'),
        content: const Text('Do you want to continue with this stock change?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Confirm')),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await ref.read(stockControllerProvider.notifier).submitEntry(
            productId: _productId!,
            type: _type,
            quantity: int.parse(_quantityController.text),
            note: _noteController.text,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stock updated successfully.')),
        );
      }
      _formKey.currentState?.reset();
      _quantityController.clear();
      _noteController.clear();
      setState(() {
        _productId = null;
        _type = StockEntryType.stockIn;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
