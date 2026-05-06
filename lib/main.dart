import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_inventory/app/app.dart';
import 'package:smart_inventory/core/constants.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';
import 'package:smart_inventory/features/stock/data/stock_entry_model.dart';

// COMMIT 1: Project Initialization
// COMMIT 4: Offline Storage + Final Integration
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(ProductModelAdapter().typeId)) {
    Hive.registerAdapter(ProductModelAdapter());
  }
  if (!Hive.isAdapterRegistered(StockEntryModelAdapter().typeId)) {
    Hive.registerAdapter(StockEntryModelAdapter());
  }

  await Hive.openBox<ProductModel>(AppConstants.productBoxName);
  await Hive.openBox<StockEntryModel>(AppConstants.stockEntryBoxName);

  runApp(const ProviderScope(child: SmartInventoryApp()));
}
