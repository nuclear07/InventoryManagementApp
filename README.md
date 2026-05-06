# Smart Inventory & Stock Replenishment

Flutter app for product management, stock in/out, low-stock alerts, dashboard metrics, stock history, and search/filter with offline-first local persistence using Hive.

## Stack
- Flutter + Material 3
- Riverpod
- Hive (local offline storage)
- GoRouter
- connectivity_plus (offline indicator)

## Implemented modules
1. **Product Management**: add/edit/delete products with validation.
2. **Stock Update**: Stock In / Stock Out with negative-stock prevention.
3. **Low Stock Alerts**: Normal (green), Low (orange), Critical (red/qty=0).
4. **Dashboard**: total/low/critical summary cards, list, recent updates, pull-to-refresh, and PDF export.
5. **Stock History**: all logs, most recent first, formatted timestamp.
6. **Search & Filter**: name search + category + stock status.
7. **Offline**: all data local in Hive; app bar online/offline indicator.
8. **Barcode & QR Scanning**: scan and detect barcode formats for quick workflows.
9. **Theme Modes**: switch between light mode and dark mode from the dashboard.

## Project structure
```
lib/
  app/
    app.dart
    app_router.dart
    app_theme.dart
  core/
    barcode_result_model.dart
    barcode_service.dart
    constants.dart
    connectivity_provider.dart
    pdf_export_service.dart
    theme_mode_provider.dart
  features/
    dashboard/presentation/dashboard_screen.dart
    product/
      data/product_model.dart
      data/product_repository.dart
      providers/product_controller.dart
      presentation/product_management_screen.dart
    stock/
      data/stock_entry_model.dart
      data/stock_repository.dart
      providers/stock_controller.dart
      presentation/stock_update_screen.dart
      presentation/stock_history_screen.dart
    search/presentation/search_filter_screen.dart
  shared/widgets/
    barcode_scanner_screen.dart
    empty_state.dart
    stock_status_chip.dart
  main.dart
```

## Setup
1. Create Flutter project at this path and keep package name `smart_inventory`.
2. Use provided `pubspec.yaml`.
3. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Required commit phases
1. **Project Initialization**
2. **UI Development**
3. **Core Logic**
4. **Offline Storage & Final Integration**
