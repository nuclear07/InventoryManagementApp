import 'package:smart_inventory/core/barcode_result_model.dart';

/// Service for handling barcode scanning operations
class BarcodeService {
  /// Validate if a string is a valid barcode
  static bool isValidBarcode(String barcode) {
    return barcode.isNotEmpty && barcode.length >= 6;
  }

  /// Detect barcode format from raw value
  static BarcodeFormat detectFormat(String rawValue) {
    final length = rawValue.length;
    final isNumeric = RegExp(r'^[0-9]+$').hasMatch(rawValue);

    if (rawValue.startsWith('{') || rawValue.startsWith('[')) {
      return BarcodeFormat.qrcode;
    }

    if (!isNumeric) {
      return BarcodeFormat.qrcode;
    }

    switch (length) {
      case 8:
        return BarcodeFormat.ean8;
      case 12:
        return BarcodeFormat.upca;
      case 13:
        return BarcodeFormat.ean13;
      case 14:
        return BarcodeFormat.code128;
      default:
        if (length > 20) {
          return BarcodeFormat.code128;
        }
        return BarcodeFormat.unknown;
    }
  }

  /// Validate barcode checksum (for EAN/UPC)
  static bool validateChecksum(String barcode) {
    if (!RegExp(r'^[0-9]+$').hasMatch(barcode)) {
      return false;
    }

    if (barcode.length < 8 || barcode.length > 14) {
      return false;
    }

    try {
      int sum = 0;
      bool isEven = false;

      for (int i = barcode.length - 2; i >= 0; i--) {
        int digit = int.parse(barcode[i]);
        if (isEven) {
          digit *= 3;
        }
        sum += digit;
        isEven = !isEven;
      }

      int checkDigit = (10 - (sum % 10)) % 10;
      int providedCheckDigit = int.parse(barcode[barcode.length - 1]);

      return checkDigit == providedCheckDigit;
    } catch (_) {
      return false;
    }
  }

  /// Extract product information from barcode
  static Map<String, dynamic> parseBarcode(String barcode) {
    final format = detectFormat(barcode);
    final isValid = isValidBarcode(barcode);
    final checksumValid = (format == BarcodeFormat.ean8 ||
            format == BarcodeFormat.ean13 ||
            format == BarcodeFormat.upca)
        ? validateChecksum(barcode)
        : true;

    return {
      'rawValue': barcode,
      'format': format,
      'isValid': isValid,
      'checksumValid': checksumValid,
      'length': barcode.length,
    };
  }

  /// Create a BarcodeResult from scanned data
  static BarcodeResult createBarcodeResult(
    String rawValue, {
    String? productId,
    String? notes,
    BarcodeFormat? format,
  }) {
    final detectedFormat = format ?? detectFormat(rawValue);
    final isValid = isValidBarcode(rawValue);

    return BarcodeResult(
      rawValue: rawValue,
      productId: productId,
      format: detectedFormat,
      notes: notes,
      isMatched: productId != null && isValid,
    );
  }

  /// Match barcode to product ID
  static String? matchBarcodeToProductId(String barcode) {
    // Placeholder for barcode-to-product mapping logic
    return null;
  }

  /// Format barcode for display
  static String formatBarcodeForDisplay(String barcode) {
    if (barcode.length > 20) {
      return '${barcode.substring(0, 10)}...${barcode.substring(barcode.length - 10)}';
    }
    return barcode;
  }

  /// Generate a test barcode (for testing purposes)
  static String generateTestBarcode({BarcodeFormat format = BarcodeFormat.ean13}) {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    String barcode = random.substring(random.length - 12);

    int sum = 0;
    bool isEven = false;
    for (int i = barcode.length - 1; i >= 0; i--) {
      int digit = int.parse(barcode[i]);
      if (isEven) {
        digit *= 3;
      }
      sum += digit;
      isEven = !isEven;
    }
    int checkDigit = (10 - (sum % 10)) % 10;
    barcode += checkDigit.toString();

    return barcode;
  }
}
