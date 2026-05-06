import 'package:flutter_test/flutter_test.dart';
import 'package:smart_inventory/core/barcode_result_model.dart';
import 'package:smart_inventory/core/barcode_service.dart';

void main() {
  group('BarcodeService', () {
    test('should validate correct barcode', () {
      expect(BarcodeService.isValidBarcode('123456'), true);
      expect(BarcodeService.isValidBarcode('12345'), false);
      expect(BarcodeService.isValidBarcode(''), false);
    });

    test('should detect EAN-13 format', () {
      final format = BarcodeService.detectFormat('5901234123457');
      expect(format, BarcodeFormat.ean13);
    });

    test('should detect EAN-8 format', () {
      final format = BarcodeService.detectFormat('96385074');
      expect(format, BarcodeFormat.ean8);
    });

    test('should detect UPC-A format', () {
      final format = BarcodeService.detectFormat('036000291452');
      expect(format, BarcodeFormat.upca);
    });

    test('should detect QR code from non-numeric string', () {
      final format = BarcodeService.detectFormat('https://example.com');
      expect(format, BarcodeFormat.qrcode);
    });

    test('should detect QR code from special characters', () {
      final format = BarcodeService.detectFormat('{test}');
      expect(format, BarcodeFormat.qrcode);
    });

    test('should validate EAN-13 checksum', () {
      // Valid EAN-13: 5901234123457
      expect(BarcodeService.validateChecksum('5901234123457'), true);
      
      // Invalid EAN-13: wrong checksum
      expect(BarcodeService.validateChecksum('5901234123456'), false);
    });

    test('should validate EAN-8 checksum', () {
      // Valid EAN-8: 96385074
      expect(BarcodeService.validateChecksum('96385074'), true);
    });

    test('should parse barcode correctly', () {
      final result = BarcodeService.parseBarcode('5901234123457');
      
      expect(result['rawValue'], '5901234123457');
      expect(result['format'], BarcodeFormat.ean13);
      expect(result['isValid'], true);
      expect(result['length'], 13);
    });

    test('should create barcode result', () {
      final result = BarcodeService.createBarcodeResult('123456789');
      
      expect(result.rawValue, '123456789');
      expect(result.format, isNotNull);
      expect(result.isMatched, false);
      expect(result.id, isNotNull);
    });

    test('should create barcode result with product ID', () {
      final result = BarcodeService.createBarcodeResult(
        '123456789',
        productId: 'prod-123',
      );
      
      expect(result.productId, 'prod-123');
      expect(result.isMatched, true);
    });

    test('should format barcode for display', () {
      final long = 'A' * 30;
      final formatted = BarcodeService.formatBarcodeForDisplay(long);
      
      expect(formatted.contains('...'), true);
      expect(formatted.length, lessThan(long.length));
    });

    test('should not truncate short barcodes', () {
      final short = '123456789';
      final formatted = BarcodeService.formatBarcodeForDisplay(short);
      
      expect(formatted, short);
      expect(formatted.contains('...'), false);
    });

    test('should generate valid test barcode', () {
      final barcode = BarcodeService.generateTestBarcode();
      
      expect(barcode.length, 13);
      expect(RegExp(r'^[0-9]+$').hasMatch(barcode), true);
    });

    test('should generate barcode with valid checksum', () {
      final barcode = BarcodeService.generateTestBarcode();
      expect(BarcodeService.validateChecksum(barcode), true);
    });

    test('should reject non-numeric barcodes for checksum', () {
      expect(BarcodeService.validateChecksum('ABC123'), false);
    });

    test('should reject barcodes with invalid length', () {
      expect(BarcodeService.validateChecksum('12345'), false); // Too short
      expect(BarcodeService.validateChecksum('123456789012345'), false); // Too long
    });
  });

  group('BarcodeResult', () {
    test('should create barcode result with auto-generated ID', () {
      final result = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
      );
      
      expect(result.id, isNotNull);
      expect(result.id.length, 36); // UUID v4 length
    });

    test('should create barcode result with provided ID', () {
      final result = BarcodeResult(
        id: 'test-id',
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
      );
      
      expect(result.id, 'test-id');
    });

    test('should set creation time to now', () {
      final now = DateTime.now();
      final result = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
      );
      
      expect(result.scannedAt.difference(now).inSeconds, lessThanOrEqualTo(1));
    });

    test('should use provided scan time', () {
      final scanTime = DateTime(2024, 1, 15, 10, 30, 0);
      final result = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
        scannedAt: scanTime,
      );
      
      expect(result.scannedAt, scanTime);
    });

    test('should format date correctly', () {
      final result = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
        scannedAt: DateTime(2024, 1, 5, 10, 30, 0),
      );
      
      expect(result.getFormattedDate(), '2024-01-05');
    });

    test('should format time correctly', () {
      final result = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
        scannedAt: DateTime(2024, 1, 5, 9, 5, 3),
      );
      
      expect(result.getFormattedTime(), '09:05:03');
    });

    test('should format datetime correctly', () {
      final result = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
        scannedAt: DateTime(2024, 1, 5, 9, 5, 3),
      );
      
      expect(result.getFormattedDateTime(), '2024-01-05 09:05:03');
    });

    test('should copy with new values', () {
      final original = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
      );
      
      final copy = original.copyWith(
        rawValue: '987654321',
        productId: 'prod-123',
      );
      
      expect(copy.rawValue, '987654321');
      expect(copy.productId, 'prod-123');
      expect(copy.format, BarcodeFormat.ean13);
      expect(copy.id, original.id);
    });

    test('should get format names', () {
      expect(BarcodeFormat.ean13.name, 'ean13');
      expect(BarcodeFormat.qrcode.name, 'qrcode');
      expect(BarcodeFormat.upca.name, 'upca');
    });

    test('should have correct matched status', () {
      final matched = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
        productId: 'prod-123',
        isMatched: true,
      );
      
      final notMatched = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
        isMatched: false,
      );
      
      expect(matched.isMatched, true);
      expect(notMatched.isMatched, false);
    });

    test('should handle optional notes', () {
      final withNotes = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
        notes: 'Test note',
      );
      
      final withoutNotes = BarcodeResult(
        rawValue: '123456789',
        format: BarcodeFormat.ean13,
      );
      
      expect(withNotes.notes, 'Test note');
      expect(withoutNotes.notes, isNull);
    });
  });
}
