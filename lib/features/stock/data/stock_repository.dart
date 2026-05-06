import 'package:hive/hive.dart';
import 'package:smart_inventory/core/constants.dart';
import 'package:smart_inventory/features/stock/data/stock_entry_model.dart';

class StockRepository {
  Box<StockEntryModel> get _box => Hive.box<StockEntryModel>(AppConstants.stockEntryBoxName);

  List<StockEntryModel> getAll() {
    final entries = _box.values.toList();
    entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return entries;
  }

  Future<void> save(StockEntryModel entry) => _box.put(entry.id, entry);
}
