import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';
import 'package:smart_inventory/shared/widgets/stock_status_chip.dart';

void main() {
  group('StockStatusChip', () {
    testWidgets('should display NORMAL status with green color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StockStatusChip(status: StockStatus.normal),
          ),
        ),
      );

      expect(find.byType(StockStatusChip), findsOneWidget);
      expect(find.text('Normal'), findsOneWidget);
    });

    testWidgets('should display LOW status with amber color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StockStatusChip(status: StockStatus.low),
          ),
        ),
      );

      expect(find.byType(StockStatusChip), findsOneWidget);
      expect(find.text('Low'), findsOneWidget);
    });

    testWidgets('should display CRITICAL status with red color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StockStatusChip(status: StockStatus.critical),
          ),
        ),
      );

      expect(find.byType(StockStatusChip), findsOneWidget);
      expect(find.text('Critical'), findsOneWidget);
    });

    testWidgets('should be renderable in a row', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                StockStatusChip(status: StockStatus.normal),
                StockStatusChip(status: StockStatus.low),
                StockStatusChip(status: StockStatus.critical),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(StockStatusChip), findsNWidgets(3));
    });
  });
}
