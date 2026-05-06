import 'package:uuid/uuid.dart';

/// Enum for barcode format types
enum BarcodeFormat {
  unknown,
  upca,
  upce,
  ean13,
  ean8,
  code128,
  code39,
  code93,
  codabar,
  qrcode,
  datamatrix,
  aztec,
  pdf417,
}

/// Model for barcode scanning results
class BarcodeResult {
  final String id;
  final String rawValue;
  final String? productId;
  final BarcodeFormat format;
  final DateTime scannedAt;
  final String? notes;
  final bool isMatched;

  BarcodeResult({
    String? id,
    required this.rawValue,
    this.productId,
    required this.format,
    DateTime? scannedAt,
    this.notes,
    this.isMatched = false,
  })  : id = id ?? const Uuid().v4(),
        scannedAt = scannedAt ?? DateTime.now();

  BarcodeResult copyWith({
    String? id,
    String? rawValue,
    String? productId,
    BarcodeFormat? format,
    DateTime? scannedAt,
    String? notes,
    bool? isMatched,
  }) {
    return BarcodeResult(
      id: id ?? this.id,
      rawValue: rawValue ?? this.rawValue,
      productId: productId ?? this.productId,
      format: format ?? this.format,
      scannedAt: scannedAt ?? this.scannedAt,
      notes: notes ?? this.notes,
      isMatched: isMatched ?? this.isMatched,
    );
  }

  String getFormattedDate() {
    return '${scannedAt.year}-${scannedAt.month.toString().padLeft(2, '0')}-${scannedAt.day.toString().padLeft(2, '0')}';
  }

  String getFormattedTime() {
    return '${scannedAt.hour.toString().padLeft(2, '0')}:${scannedAt.minute.toString().padLeft(2, '0')}:${scannedAt.second.toString().padLeft(2, '0')}';
  }

  String getFormattedDateTime() {
    return '${getFormattedDate()} ${getFormattedTime()}';
  }

  String getFormatName() {
    switch (format) {
      case BarcodeFormat.upca:
        return 'UPC-A';
      case BarcodeFormat.upce:
        return 'UPC-E';
      case BarcodeFormat.ean13:
        return 'EAN-13';
      case BarcodeFormat.ean8:
        return 'EAN-8';
      case BarcodeFormat.code128:
        return 'Code 128';
      case BarcodeFormat.code39:
        return 'Code 39';
      case BarcodeFormat.code93:
        return 'Code 93';
      case BarcodeFormat.codabar:
        return 'Codabar';
      case BarcodeFormat.qrcode:
        return 'QR Code';
      case BarcodeFormat.datamatrix:
        return 'Data Matrix';
      case BarcodeFormat.aztec:
        return 'Aztec';
      case BarcodeFormat.pdf417:
        return 'PDF417';
      case BarcodeFormat.unknown:
        return 'Unknown';
    }
  }

  @override
  String toString() => 'BarcodeResult(id: $id, rawValue: $rawValue, format: ${getFormatName()})';
}
