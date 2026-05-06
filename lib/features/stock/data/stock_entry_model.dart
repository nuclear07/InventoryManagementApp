import 'package:hive/hive.dart';

enum StockEntryType { stockIn, stockOut }

class StockEntryModel {
  final String id;
  final String productId;
  final String productName;
  final StockEntryType type;
  final int quantity;
  final DateTime timestamp;
  final String note;

  const StockEntryModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.type,
    required this.quantity,
    required this.timestamp,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'type': type.name,
      'quantity': quantity,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'note': note,
    };
  }

  factory StockEntryModel.fromMap(Map<dynamic, dynamic> map) {
    return StockEntryModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      type: StockEntryType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => StockEntryType.stockIn,
      ),
      quantity: map['quantity'] as int,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      note: (map['note'] as String?) ?? '',
    );
  }
}

class StockEntryModelAdapter extends TypeAdapter<StockEntryModel> {
  @override
  final int typeId = 1;

  @override
  StockEntryModel read(BinaryReader reader) {
    final map = Map<dynamic, dynamic>.from(reader.readMap());
    return StockEntryModel.fromMap(map);
  }

  @override
  void write(BinaryWriter writer, StockEntryModel obj) {
    writer.writeMap(obj.toMap());
  }
}
