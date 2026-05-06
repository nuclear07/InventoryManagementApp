import 'package:flutter_test/flutter_test.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';

class TestBox {
  final Map<dynamic, ProductModel> _data = {};

  Future<void> add(ProductModel value) async {
    _data[value.id] = value;
  }

  ProductModel? get(dynamic key) {
    return _data[key];
  }

  Future<void> put(dynamic key, ProductModel value) async {
    _data[key] = value;
  }

  Future<void> delete(dynamic key) async {
    _data.remove(key);
  }

  List<ProductModel> values() {
    return _data.values.toList();
  }

  Future<void> clear() async {
    _data.clear();
  }
}

void main() {
  group('Repository Pattern', () {
    late TestBox mockBox;

    setUp(() {
      mockBox = TestBox();
    });

    test('should add product to repository', () async {
      final product = ProductModel(
        id: '1',
        name: 'Test Product',
        category: ProductCategory.electronics,
        quantityAvailable: 10,
        minimumThreshold: 5,
        lastModified: DateTime.now(),
      );

      await mockBox.add(product);
      final retrieved = mockBox.get('1');

      expect(retrieved, isNotNull);
      expect(retrieved!.name, 'Test Product');
    });

    test('should retrieve product from repository', () async {
      final product = ProductModel(
        id: '2',
        name: 'Laptop',
        category: ProductCategory.electronics,
        quantityAvailable: 5,
        minimumThreshold: 2,
        lastModified: DateTime.now(),
      );

      await mockBox.add(product);
      final retrieved = mockBox.get('2');

      expect(retrieved, isNotNull);
      expect(retrieved!.id, '2');
      expect(retrieved!.quantityAvailable, 5);
    });

    test('should update product in repository', () async {
      var product = ProductModel(
        id: '3',
        name: 'Original Name',
        category: ProductCategory.stationery,
        quantityAvailable: 10,
        minimumThreshold: 5,
        lastModified: DateTime.now(),
      );

      await mockBox.add(product);

      product = product.copyWith(name: 'Updated Name');
      await mockBox.put('3', product);

      final retrieved = mockBox.get('3');
      expect(retrieved!.name, 'Updated Name');
    });

    test('should delete product from repository', () async {
      final product = ProductModel(
        id: '4',
        name: 'To Delete',
        category: ProductCategory.food,
        quantityAvailable: 8,
        minimumThreshold: 3,
        lastModified: DateTime.now(),
      );

      await mockBox.add(product);
      await mockBox.delete('4');

      final retrieved = mockBox.get('4');
      expect(retrieved, isNull);
    });

    test('should retrieve all products', () async {
      final product1 = ProductModel(
        id: '1',
        name: 'Product 1',
        category: ProductCategory.electronics,
        quantityAvailable: 10,
        minimumThreshold: 5,
        lastModified: DateTime.now(),
      );

      final product2 = ProductModel(
        id: '2',
        name: 'Product 2',
        category: ProductCategory.stationery,
        quantityAvailable: 20,
        minimumThreshold: 10,
        lastModified: DateTime.now(),
      );

      await mockBox.add(product1);
      await mockBox.add(product2);

      final allProducts = mockBox.values();
      expect(allProducts.length, 2);
    });

    test('should clear all products', () async {
      final product = ProductModel(
        id: '1',
        name: 'Test',
        category: ProductCategory.electronics,
        quantityAvailable: 5,
        minimumThreshold: 2,
        lastModified: DateTime.now(),
      );

      await mockBox.add(product);
      await mockBox.clear();

      final allProducts = mockBox.values();
      expect(allProducts.length, 0);
    });
  });
}
