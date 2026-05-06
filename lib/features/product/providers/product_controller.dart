import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';
import 'package:smart_inventory/features/product/data/product_repository.dart';
import 'package:uuid/uuid.dart';

// COMMIT 3: Core Logic
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<List<ProductModel>>>((ref) {
  return ProductController(ref)..reload();
});

final summaryProvider = Provider<({int total, int low, int critical})>((ref) {
  final products = ref.watch(productControllerProvider).valueOrNull ?? const <ProductModel>[];
  final low = products.where((p) => p.stockStatus == StockStatus.low).length;
  final critical = products.where((p) => p.stockStatus == StockStatus.critical).length;
  return (total: products.length, low: low, critical: critical);
});

class ProductController extends StateNotifier<AsyncValue<List<ProductModel>>> {
  ProductController(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  final _uuid = const Uuid();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(ref.read(productRepositoryProvider).getAll());
  }

  Future<void> addProduct({
    required String name,
    required ProductCategory category,
    required int quantityAvailable,
    required int minimumThreshold,
  }) async {
    final product = ProductModel(
      id: _uuid.v4(),
      name: name.trim(),
      category: category,
      quantityAvailable: quantityAvailable,
      minimumThreshold: minimumThreshold,
      lastModified: DateTime.now(),
    );
    await ref.read(productRepositoryProvider).save(product);
    await reload();
  }

  Future<void> updateProduct(ProductModel product) async {
    await ref.read(productRepositoryProvider).save(
          product.copyWith(lastModified: DateTime.now()),
        );
    await reload();
  }

  Future<void> deleteProduct(String id) async {
    await ref.read(productRepositoryProvider).delete(id);
    await reload();
  }
}
