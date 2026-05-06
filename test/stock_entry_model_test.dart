import 'package:flutter_test/flutter_test.dart';
import 'package:smart_inventory/features/stock/data/stock_entry_model.dart';

void main() {
  group('StockEntryModel', () {
    test('should create a stock entry with valid data', () {
      final now = DateTime.now();
      final entry = StockEntryModel(
        id: '1',
        productId: 'prod-1',
        productName: 'Test Product',
        type: StockEntryType.stockIn,
        quantity: 5,
        timestamp: now,
        note: 'Received from supplier',
      );

      expect(entry.id, '1');
      expect(entry.productId, 'prod-1');
      expect(entry.type, StockEntryType.stockIn);
      expect(entry.quantity, 5);
      expect(entry.timestamp, now);
      expect(entry.note, 'Received from supplier');
    });

    test('should identify stockIn entries', () {
      final entry = StockEntryModel(
        id: '1',
        productId: 'prod-1',
        productName: 'Test Product',
        type: StockEntryType.stockIn,
        quantity: 5,
        timestamp: DateTime.now(),
        note: '',
      );

      expect(entry.type, StockEntryType.stockIn);
      expect(entry.type == StockEntryType.stockIn, true);
    });

    test('should identify stockOut entries', () {
      final entry = StockEntryModel(
        id: '1',
        productId: 'prod-1',
        productName: 'Test Product',
        type: StockEntryType.stockOut,
        quantity: 3,
        timestamp: DateTime.now(),
        note: '',
      );

      expect(entry.type, StockEntryType.stockOut);
      expect(entry.type == StockEntryType.stockOut, true);
    });

    test('should format date correctly', () {
      final entry = StockEntryModel(
        id: '1',
        productId: 'prod-1',
        productName: 'Test Product',
        type: StockEntryType.stockIn,
        quantity: 5,
        timestamp: DateTime(2024, 1, 15),
        note: '',
      );

      final formattedDate = entry.toMap()['timestamp'] as int;
      expect(formattedDate, greaterThan(0));
    });

    test('should handle optional notes', () {
      final entryWithNote = StockEntryModel(
        id: '1',
        productId: 'prod-1',
        productName: 'Test Product',
        type: StockEntryType.stockIn,
        quantity: 5,
        timestamp: DateTime.now(),
        note: 'Important note',
      );

      final entryWithoutNote = StockEntryModel(
        id: '2',
        productId: 'prod-1',
        productName: 'Test Product',
        type: StockEntryType.stockIn,
        quantity: 5,
        timestamp: DateTime.now(),
        note: '',
      );

      expect(entryWithNote.note, 'Important note');
      expect(entryWithoutNote.note, isEmpty);
    });

    test('should support map conversion', () {
      final original = StockEntryModel(
        id: '1',
        productId: 'prod-1',
        productName: 'Test Product',
        type: StockEntryType.stockIn,
        quantity: 5,
        timestamp: DateTime.now(),
        note: '',
      );

      final map = original.toMap();
      final updated = StockEntryModel.fromMap(map);

      expect(updated.quantity, original.quantity);
      expect(updated.id, original.id);
      expect(updated.productId, original.productId);
    });

    test('should track timestamps accurately', () {
      final now = DateTime.now();
      final entry = StockEntryModel(
        id: '1',
        productId: 'prod-1',
        productName: 'Test Product',
        type: StockEntryType.stockIn,
        quantity: 5,
        timestamp: now,
        note: '',
      );

      expect(entry.timestamp.year, now.year);
      expect(entry.timestamp.month, now.month);
      expect(entry.timestamp.day, now.day);
    });
  });
}
