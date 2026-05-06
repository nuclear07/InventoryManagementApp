import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';
import 'package:smart_inventory/features/stock/data/stock_entry_model.dart';

class PdfExportService {
  static Future<void> exportInventoryReport({
    required List<ProductModel> products,
    required List<StockEntryModel> stockEntries,
  }) async {
    final pdf = pw.Document();
    final now = DateTime.now();
    final dateTime = DateFormat('dd MMM yyyy, hh:mm a').format(now);
    final lowCount = products.where((p) => p.stockStatus == StockStatus.low).length;
    final criticalCount = products.where((p) => p.stockStatus == StockStatus.critical).length;

    pdf.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(
          margin: pw.EdgeInsets.all(24),
          pageFormat: PdfPageFormat.a4,
        ),
        build: (context) => [
          pw.Text(
            'Smart Inventory Report',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text('Generated on $dateTime'),
          pw.SizedBox(height: 16),
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey400),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                _metricItem('Total Products', '${products.length}'),
                _metricItem('Low Stock', '$lowCount'),
                _metricItem('Out of Stock', '$criticalCount'),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'Product Inventory',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          _productTable(products),
          pw.SizedBox(height: 20),
          pw.Text(
            'Recent Stock Activity',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          _stockEntriesTable(stockEntries.take(30).toList()),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'smart_inventory_report_${DateFormat('yyyyMMdd_HHmm').format(now)}',
    );
  }

  static pw.Widget _metricItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(label, style: const pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  static pw.Widget _productTable(List<ProductModel> products) {
    if (products.isEmpty) {
      return pw.Text('No products available');
    }

    return pw.TableHelper.fromTextArray(
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
      cellAlignment: pw.Alignment.centerLeft,
      headerAlignment: pw.Alignment.centerLeft,
      columnWidths: const {
        0: pw.FlexColumnWidth(2.5),
        1: pw.FlexColumnWidth(1.7),
        2: pw.FlexColumnWidth(1),
        3: pw.FlexColumnWidth(1),
        4: pw.FlexColumnWidth(1.2),
      },
      headers: ['Product', 'Category', 'Qty', 'Min', 'Status'],
      data: products
          .map(
            (p) => [
              p.name,
              p.category.label,
              '${p.quantityAvailable}',
              '${p.minimumThreshold}',
              p.stockStatus.name.toUpperCase(),
            ],
          )
          .toList(),
    );
  }

  static pw.Widget _stockEntriesTable(List<StockEntryModel> entries) {
    if (entries.isEmpty) {
      return pw.Text('No stock activity available');
    }

    return pw.TableHelper.fromTextArray(
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
      cellAlignment: pw.Alignment.centerLeft,
      headerAlignment: pw.Alignment.centerLeft,
      columnWidths: const {
        0: pw.FlexColumnWidth(2.2),
        1: pw.FlexColumnWidth(1.1),
        2: pw.FlexColumnWidth(0.8),
        3: pw.FlexColumnWidth(1.5),
        4: pw.FlexColumnWidth(1.6),
      },
      headers: ['Product', 'Type', 'Qty', 'Date', 'Note'],
      data: entries
          .map(
            (e) => [
              e.productName,
              e.type == StockEntryType.stockIn ? 'IN' : 'OUT',
              '${e.quantity}',
              DateFormat('dd MMM, hh:mm a').format(e.timestamp),
              e.note.isEmpty ? '-' : e.note,
            ],
          )
          .toList(),
    );
  }
}
