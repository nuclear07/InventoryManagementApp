import 'package:hive/hive.dart';

enum ProductCategory { electronics, stationery, labEquipment, food }

extension ProductCategoryX on ProductCategory {
  String get label {
    switch (this) {
      case ProductCategory.electronics:
        return 'Electronics';
      case ProductCategory.stationery:
        return 'Stationery';
      case ProductCategory.labEquipment:
        return 'Lab Equipment';
      case ProductCategory.food:
        return 'Food';
    }
  }

  static ProductCategory fromName(String value) {
    return ProductCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ProductCategory.electronics,
    );
  }
}

enum StockStatus { normal, low, critical }

class ProductModel {
  final String id;
  final String name;
  final ProductCategory category;
  final int quantityAvailable;
  final int minimumThreshold;
  final DateTime lastModified;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.quantityAvailable,
    required this.minimumThreshold,
    required this.lastModified,
  });

  StockStatus get stockStatus {
    if (quantityAvailable == 0) return StockStatus.critical;
    if (quantityAvailable <= minimumThreshold) return StockStatus.low;
    return StockStatus.normal;
  }

  ProductModel copyWith({
    String? id,
    String? name,
    ProductCategory? category,
    int? quantityAvailable,
    int? minimumThreshold,
    DateTime? lastModified,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantityAvailable: quantityAvailable ?? this.quantityAvailable,
      minimumThreshold: minimumThreshold ?? this.minimumThreshold,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category.name,
      'quantityAvailable': quantityAvailable,
      'minimumThreshold': minimumThreshold,
      'lastModified': lastModified.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      category: ProductCategoryX.fromName(map['category'] as String),
      quantityAvailable: map['quantityAvailable'] as int,
      minimumThreshold: map['minimumThreshold'] as int,
      lastModified: DateTime.fromMillisecondsSinceEpoch(map['lastModified'] as int),
    );
  }
}

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final map = Map<dynamic, dynamic>.from(reader.readMap());
    return ProductModel.fromMap(map);
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.writeMap(obj.toMap());
  }
}
