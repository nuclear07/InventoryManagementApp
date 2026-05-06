import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';
import 'package:smart_inventory/features/product/providers/product_controller.dart';

// COMMIT 2: UI Development
class ProductManagementScreen extends ConsumerStatefulWidget {
  const ProductManagementScreen({super.key, this.productId});

  final String? productId;

  @override
  ConsumerState<ProductManagementScreen> createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends ConsumerState<ProductManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _qtyController = TextEditingController();
  final _thresholdController = TextEditingController();
  ProductCategory _category = ProductCategory.electronics;
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _qtyController.dispose();
    _thresholdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productControllerProvider).valueOrNull ?? const <ProductModel>[];
    ProductModel? existing;
    if (widget.productId != null) {
      for (final p in products) {
        if (p.id == widget.productId) {
          existing = p;
          break;
        }
      }
    }

    if (!_initialized && existing != null) {
      _nameController.text = existing.name;
      _qtyController.text = existing.quantityAvailable.toString();
      _thresholdController.text = existing.minimumThreshold.toString();
      _category = existing.category;
      _initialized = true;
    }

    final editingProduct = existing;
    final isEdit = editingProduct != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Product' : 'Add Product'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Product name is required.'
                  : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ProductCategory>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: ProductCategory.values
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.label)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _qtyController,
              decoration: const InputDecoration(labelText: 'Quantity Available'),
              keyboardType: TextInputType.number,
              validator: _nonNegativeValidator,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _thresholdController,
              decoration: const InputDecoration(labelText: 'Minimum Threshold'),
              keyboardType: TextInputType.number,
              validator: _nonNegativeValidator,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => _save(editingProduct),
              child: Text(isEdit ? 'Update Product' : 'Save Product'),
            ),
            if (isEdit) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () async {
                  await ref
                      .read(productControllerProvider.notifier)
                      .deleteProduct(editingProduct!.id);
                  if (mounted) context.pop();
                },
                child: const Text('Delete Product'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String? _nonNegativeValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required field.';
    final parsed = int.tryParse(value);
    if (parsed == null) return 'Enter a valid integer.';
    if (parsed < 0) return 'Negative values are not allowed.';
    return null;
  }

  Future<void> _save(ProductModel? existing) async {
    if (!_formKey.currentState!.validate()) return;
    final qty = int.parse(_qtyController.text);
    final threshold = int.parse(_thresholdController.text);
    if (threshold < 0 || qty < 0) return;

    final controller = ref.read(productControllerProvider.notifier);
    if (existing == null) {
      await controller.addProduct(
        name: _nameController.text,
        category: _category,
        quantityAvailable: qty,
        minimumThreshold: threshold,
      );
    } else {
      await controller.updateProduct(
        existing.copyWith(
          name: _nameController.text.trim(),
          category: _category,
          quantityAvailable: qty,
          minimumThreshold: threshold,
        ),
      );
    }
    if (mounted) context.pop();
  }
}
