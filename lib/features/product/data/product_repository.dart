import 'package:hive/hive.dart';
import 'package:smart_inventory/core/constants.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';

class ProductRepository {
  Box<ProductModel> get _box => Hive.box<ProductModel>(AppConstants.productBoxName);

  List<ProductModel> getAll() {
    final products = _box.values.toList();
    products.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return products;
  }

  ProductModel? getById(String id) => _box.get(id);

  Future<void> save(ProductModel product) => _box.put(product.id, product);

  Future<void> delete(String id) => _box.delete(id);
}
