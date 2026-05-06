import 'package:flutter_test/flutter_test.dart';
import 'package:smart_inventory/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateProductName', () {
      test('should return null for valid product name', () {
        final result = validateProductName('Valid Product Name');
        expect(result, isNull);
      });

      test('should return error for empty name', () {
        final result = validateProductName('');
        expect(result, isNotNull);
        expect(result, contains('required'));
      });

      test('should return error for name shorter than 2 characters', () {
        final result = validateProductName('A');
        expect(result, isNotNull);
      });

      test('should return error for name longer than 100 characters', () {
        final longName = 'A' * 101;
        final result = validateProductName(longName);
        expect(result, isNotNull);
      });

      test('should accept exactly 2 character names', () {
        final result = validateProductName('AB');
        expect(result, isNull);
      });

      test('should accept exactly 100 character names', () {
        final longName = 'A' * 100;
        final result = validateProductName(longName);
        expect(result, isNull);
      });
    });

    group('validateQuantity', () {
      test('should return null for valid quantity', () {
        final result = validateQuantity('10');
        expect(result, isNull);
      });

      test('should return error for empty quantity', () {
        final result = validateQuantity('');
        expect(result, isNotNull);
      });

      test('should return error for non-numeric quantity', () {
        final result = validateQuantity('abc');
        expect(result, isNotNull);
      });

      test('should return error for negative quantity', () {
        final result = validateQuantity('-5');
        expect(result, isNotNull);
      });

      test('should accept zero quantity', () {
        final result = validateQuantity('0');
        expect(result, isNull);
      });

      test('should accept large quantities', () {
        final result = validateQuantity('999999');
        expect(result, isNull);
      });
    });

    group('validateThreshold', () {
      test('should return null for valid threshold', () {
        final result = validateThreshold('5');
        expect(result, isNull);
      });

      test('should return error for empty threshold', () {
        final result = validateThreshold('');
        expect(result, isNotNull);
      });

      test('should return error for non-numeric threshold', () {
        final result = validateThreshold('xyz');
        expect(result, isNotNull);
      });

      test('should return error for negative threshold', () {
        final result = validateThreshold('-1');
        expect(result, isNotNull);
      });

      test('should accept zero threshold', () {
        final result = validateThreshold('0');
        expect(result, isNull);
      });
    });

    group('validateStockQuantity', () {
      test('should return null for valid stock quantity', () {
        final result = validateStockQuantity('5');
        expect(result, isNull);
      });

      test('should return error for empty quantity', () {
        final result = validateStockQuantity('');
        expect(result, isNotNull);
      });

      test('should return error for non-numeric quantity', () {
        final result = validateStockQuantity('hello');
        expect(result, isNotNull);
      });

      test('should return error for zero quantity', () {
        final result = validateStockQuantity('0');
        expect(result, isNotNull);
      });

      test('should return error for negative quantity', () {
        final result = validateStockQuantity('-5');
        expect(result, isNotNull);
      });

      test('should accept positive quantities', () {
        final result = validateStockQuantity('100');
        expect(result, isNull);
      });
    });
  });
}
