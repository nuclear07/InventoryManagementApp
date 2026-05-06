import 'package:flutter_test/flutter_test.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';

void main() {
  group('ProductModel', () {
    test('should create a product with valid data', () {
      final product = ProductModel(
        id: '1',
        name: 'Laptop',
        category: ProductCategory.electronics,
        quantityAvailable: 10,
        minimumThreshold: 5,
        lastModified: DateTime(2024, 1, 1),
      );

      expect(product.id, '1');
      expect(product.name, 'Laptop');
      expect(product.category, ProductCategory.electronics);
      expect(product.quantityAvailable, 10);
      expect(product.minimumThreshold, 5);
    });

    test('should detect NORMAL stock status when quantity > threshold', () {
      final product = ProductModel(
        id: '1',
        name: 'Laptop',
        category: ProductCategory.electronics,
        quantityAvailable: 10,
        minimumThreshold: 5,
        lastModified: DateTime.now(),
      );

      expect(product.stockStatus, StockStatus.normal);
    });

    test('should detect LOW stock status when quantity == threshold', () {
      final product = ProductModel(
        id: '1',
        name: 'Laptop',
        category: ProductCategory.electronics,
        quantityAvailable: 5,
        minimumThreshold: 5,
        lastModified: DateTime.now(),
      );

      expect(product.stockStatus, StockStatus.low);
    });

    test('should detect LOW stock status when quantity < threshold', () {
      final product = ProductModel(
        id: '1',
        name: 'Laptop',
        category: ProductCategory.electronics,
        quantityAvailable: 3,
        minimumThreshold: 5,
        lastModified: DateTime.now(),
      );

      expect(product.stockStatus, StockStatus.low);
    });

    test('should detect CRITICAL stock status when quantity == 0', () {
      final product = ProductModel(
        id: '1',
        name: 'Laptop',
        category: ProductCategory.electronics,
        quantityAvailable: 0,
        minimumThreshold: 5,
        lastModified: DateTime.now(),
      );

      expect(product.stockStatus, StockStatus.critical);
    });

    test('should update product properties', () {
      final product = ProductModel(
        id: '1',
        name: 'Laptop',
        category: ProductCategory.electronics,
        quantityAvailable: 10,
        minimumThreshold: 5,
        lastModified: DateTime.now(),
      );

      final updated = product.copyWith(quantityAvailable: 20);

      expect(updated.quantityAvailable, 20);
      expect(updated.name, product.name);
      expect(updated.id, product.id);
    });

    test('should handle all product categories', () {
      final categories = [
        ProductCategory.electronics,
        ProductCategory.stationery,
        ProductCategory.labEquipment,
        ProductCategory.food,
      ];

      for (final category in categories) {
        final product = ProductModel(
          id: '1',
          name: 'Test Product',
          category: category,
          quantityAvailable: 10,
          minimumThreshold: 5,
          lastModified: DateTime.now(),
        );

        expect(product.category, category);
      }
    });
  });
}
