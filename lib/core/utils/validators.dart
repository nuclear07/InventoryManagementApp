String? validateProductName(String? value) {
  final name = value?.trim() ?? '';
  if (name.isEmpty) return 'Product name is required.';
  if (name.length < 2) return 'Product name must be at least 2 characters.';
  if (name.length > 100) return 'Product name must be at most 100 characters.';
  return null;
}

String? validateQuantity(String? value) {
  final raw = value?.trim() ?? '';
  if (raw.isEmpty) return 'Quantity is required.';
  final parsed = int.tryParse(raw);
  if (parsed == null) return 'Enter a valid integer.';
  if (parsed < 0) return 'Negative values are not allowed.';
  return null;
}

String? validateThreshold(String? value) {
  final raw = value?.trim() ?? '';
  if (raw.isEmpty) return 'Threshold is required.';
  final parsed = int.tryParse(raw);
  if (parsed == null) return 'Enter a valid integer.';
  if (parsed < 0) return 'Negative values are not allowed.';
  return null;
}

String? validateStockQuantity(String? value) {
  final raw = value?.trim() ?? '';
  if (raw.isEmpty) return 'Quantity is required.';
  final parsed = int.tryParse(raw);
  if (parsed == null) return 'Enter a valid integer.';
  if (parsed <= 0) return 'Enter a value greater than 0.';
  return null;
}
