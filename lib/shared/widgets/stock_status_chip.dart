import 'package:flutter/material.dart';
import 'package:smart_inventory/features/product/data/product_model.dart';

class StockStatusChip extends StatelessWidget {
  const StockStatusChip({super.key, required this.status});

  final StockStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      StockStatus.normal => ('Normal', Colors.green),
      StockStatus.low => ('Low', Colors.orange),
      StockStatus.critical => ('Critical', Colors.red),
    };

    return Chip(
      backgroundColor: color.withAlpha(30),
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      side: BorderSide(color: color.withAlpha(90)),
    );
  }
}
