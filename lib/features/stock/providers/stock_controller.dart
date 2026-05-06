import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_inventory/features/product/providers/product_controller.dart';
import 'package:smart_inventory/features/stock/data/stock_entry_model.dart';
import 'package:smart_inventory/features/stock/data/stock_repository.dart';
import 'package:uuid/uuid.dart';

// COMMIT 3: Core Logic
final stockRepositoryProvider = Provider<StockRepository>((ref) {
  return StockRepository();
});

final stockControllerProvider =
    StateNotifierProvider<StockController, AsyncValue<List<StockEntryModel>>>((ref) {
  return StockController(ref)..reload();
});

class StockController extends StateNotifier<AsyncValue<List<StockEntryModel>>> {
  StockController(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  final _uuid = const Uuid();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(ref.read(stockRepositoryProvider).getAll());
  }

  Future<void> submitEntry({
    required String productId,
    required StockEntryType type,
    required int quantity,
    String note = '',
  }) async {
    final productRepo = ref.read(productRepositoryProvider);
    final product = productRepo.getById(productId);
    if (product == null) {
      throw Exception('Selected product was not found.');
    }
    if (quantity <= 0) {
      throw Exception('Quantity must be greater than 0.');
    }

    if (type == StockEntryType.stockOut && product.quantityAvailable - quantity < 0) {
      throw Exception('Stock Out would make quantity negative.');
    }

    final updatedQty = type == StockEntryType.stockIn
        ? product.quantityAvailable + quantity
        : product.quantityAvailable - quantity;

    await productRepo.save(
      product.copyWith(
        quantityAvailable: updatedQty,
        lastModified: DateTime.now(),
      ),
    );

    await ref.read(stockRepositoryProvider).save(
          StockEntryModel(
            id: _uuid.v4(),
            productId: product.id,
            productName: product.name,
            type: type,
            quantity: quantity,
            timestamp: DateTime.now(),
            note: note.trim(),
          ),
        );

    await ref.read(productControllerProvider.notifier).reload();
    await reload();
  }
}
