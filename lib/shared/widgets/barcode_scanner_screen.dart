import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_inventory/core/barcode_result_model.dart' as inventory;
import 'package:smart_inventory/core/barcode_service.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  String? scannedBarcode;
  inventory.BarcodeResult? barcodeResult;
  bool isProcessing = false;
  final List<String> scannedBarcodes = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleDetection(BarcodeCapture barcodes) {
    if (isProcessing) return;

    for (final barcode in barcodes.barcodes) {
      final value = barcode.rawValue;

      if (value != null && value.isNotEmpty) {
        isProcessing = true;

        if (BarcodeService.isValidBarcode(value)) {
          setState(() {
            scannedBarcode = value;
            barcodeResult = BarcodeService.createBarcodeResult(value);
            if (!scannedBarcodes.contains(value)) {
              scannedBarcodes.add(value);
            }
          });

          controller.stop();
          _showBarcodeResultDialog(value);
        }

        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() => isProcessing = false);
            controller.start();
          }
        });

        break;
      }
    }
  }

  void _showBarcodeResultDialog(String barcode) {
    final result = BarcodeService.parseBarcode(barcode);
    final format = result['format'] as inventory.BarcodeFormat;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Barcode Detected'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Value: ${BarcodeService.formatBarcodeForDisplay(barcode)}',
                  style: TextStyle(fontFamily: 'monospace')),
              SizedBox(height: 8),
              Text('Format: ${(format).toString().split('.').last.toUpperCase()}'),
              Text('Length: ${barcode.length}'),
              Text('Valid: ${result['isValid'] ? "✓ Yes" : "✗ No"}'),
              if (format == inventory.BarcodeFormat.ean13 ||
                  format == inventory.BarcodeFormat.ean8 ||
                  format == inventory.BarcodeFormat.upca)
                Text('Checksum: ${result['checksumValid'] ? "✓ Valid" : "✗ Invalid"}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Rescan'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, barcode);
            },
            child: Text('Use'),
          ),
        ],
      ),
    );
  }

  void _useTestBarcode() {
    final testBarcode = BarcodeService.generateTestBarcode();
    Navigator.pop(context, testBarcode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Barcode/QR Code'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () => controller.toggleTorch(),
            tooltip: 'Toggle Flash',
          ),
          IconButton(
            icon: Icon(Icons.flip),
            onPressed: () => controller.switchCamera(),
            tooltip: 'Switch Camera',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: controller,
              onDetect: _handleDetection,
              errorBuilder: (context, error, child) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 64),
                      SizedBox(height: 16),
                      Text(
                        'Camera Permission Required',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8),
                      Text('Please enable camera permission in settings'),
                    ],
                  ),
                );
              },
            ),
          ),
          if (scannedBarcode != null)
            Container(
              color: Colors.green,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Last Scan: ${BarcodeService.formatBarcodeForDisplay(scannedBarcode!)}',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: _useTestBarcode,
                    child: Text('Use Test Barcode'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
