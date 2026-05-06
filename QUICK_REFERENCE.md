================================================================================
QUICK REFERENCE GUIDE
Smart Inventory & Stock Replenishment App
================================================================================

QUICK START
===========

1. Create Flutter project:
   flutter create --org com.example smart_inventory
   cd smart_inventory

2. Copy all .dart files from source code files

3. Replace pubspec.yaml

4. Install dependencies:
   flutter pub get

5. Generate code:
   flutter pub run build_runner build

6. Run app:
   flutter run

================================================================================
FILE CHECKLIST (20 FILES)
================================================================================

☐ pubspec.yaml                                  (Dependencies)
☐ lib/main.dart                                 (Entry point)

MODELS (2 files)
☐ lib/models/product_model.dart                 (Hive model)
☐ lib/models/stock_entry_model.dart             (Hive model)

CORE (3 files)
☐ lib/core/constants/app_constants.dart         (Constants)
☐ lib/core/theme/app_theme.dart                 (Material 3 theme)
☐ lib/core/utils/validators.dart                (Validation logic)

DATA REPOSITORIES (2 files)
☐ lib/data/repositories/product_repository.dart        (Product CRUD)
☐ lib/data/repositories/stock_entry_repository.dart    (Stock logs)

PROVIDERS (2 files)
☐ lib/providers/product_provider.dart           (Riverpod state)
☐ lib/providers/stock_provider.dart             (Riverpod state)

ROUTES (1 file)
☐ lib/presentation/routes/app_router.dart       (GoRouter config)

SCREENS (5 files)
☐ lib/presentation/screens/dashboard_screen.dart           (Home screen)
☐ lib/presentation/screens/product_management_screen.dart  (Add/Edit)
☐ lib/presentation/screens/stock_update_screen.dart        (Record stock)
☐ lib/presentation/screens/stock_history_screen.dart       (View logs)
☐ lib/presentation/screens/search_filter_screen.dart       (Search/Filter)

WIDGETS (3 files)
☐ lib/presentation/widgets/stock_status_badge.dart    (Status indicator)
☐ lib/presentation/widgets/product_form.dart          (Form widget)
☐ lib/presentation/widgets/empty_state_widget.dart    (Empty state)

DOCUMENTATION (4 files)
☐ README.md                                      (Main docs)
☐ IMPLEMENTATION_GUIDE.md                        (Step-by-step)
☐ .gitignore                                     (Git ignore rules)

TOTAL: 23 files

================================================================================
SCREENS AT A GLANCE
================================================================================

Screen 1: Dashboard (/)
  - Summary cards: Total Products, Low Stock, Out of Stock
  - Product list with status badges
  - Pull-to-refresh
  - FAB to add product
  - Navigation: Search (button), History (button), Add Product (FAB)

Screen 2: Product Management (/product-management)
  - Form fields: Name, Category, Quantity, Threshold
  - Actions: Save/Update, Delete
  - Input validation
  - Success/Error feedback

Screen 3: Stock Update (/stock-update)
  - Product dropdown
  - Type selector: Stock In / Stock Out
  - Quantity input
  - Optional note
  - Submit button with validation

Screen 4: Stock History (/stock-history)
  - Transaction list sorted by recent first
  - Color coding: Green (in), Red (out)
  - Timestamp and product name
  - Optional notes display

Screen 5: Search & Filter (/search-filter)
  - Search bar
  - Category filter chips
  - Stock status filter (Normal, Low, Critical)
  - Live results update
  - Product cards with status badges

================================================================================
KEY CONCEPTS
================================================================================

STATE MANAGEMENT: Riverpod
  - FutureProvider: Async data loading
  - StateProvider: Mutable state
  - Provider: Read-only computed values
  - Invalidation: ref.refresh() to update UI

LOCAL STORAGE: Hive
  - Fast, no SQL needed
  - Type-safe with code generation
  - Models have @HiveType decorator
  - Register adapters in main.dart
  - Open boxes before use

VALIDATION: Custom validators
  - Product name: 2-100 chars
  - Quantity: Positive integer
  - Threshold: Non-negative integer
  - Stock out: Prevent going negative

DESIGN: Material 3
  - Color scheme: Blue primary
  - Status colors: Green/Amber/Red
  - Rounded corners: 12px
  - Cards throughout
  - Smooth navigation

================================================================================
CODE SNIPPETS
================================================================================

Add Product Example:
-------------------
final repo = ProductRepository();
await repo.init();
await repo.addProduct(
  name: "Laptop",
  category: ProductCategory.electronics,
  quantityAvailable: 5,
  minimumThreshold: 2,
);

Stock Update Example:
-------------------
await ref.read(updateStockProvider(
  (
    productId: "prod-123",
    type: StockEntryType.stockIn,
    quantity: 10,
    note: "Restocking",
  ),
).future);

Search Products Example:
-----------------------
final repo = ProductRepository();
await repo.init();
final results = repo.searchProducts("laptop");

Get Stock Status Example:
------------------------
final product = repo.getProduct("prod-123");
final status = product.getStockStatus(); // Returns: StockStatus enum

Navigation Examples:
------------------
context.push('/product-management');           // Add product
context.push('/product-management?id=$id');    // Edit product
context.push('/stock-update');                 // Stock update
context.push('/stock-history');                // View history
context.push('/search-filter');                // Search/filter

Riverpod Refresh Example:
------------------------
ref.refresh(allProductsProvider);
ref.refresh(lowStockCountProvider);
ref.refresh(outOfStockCountProvider);

================================================================================
COMMON TASKS
================================================================================

Task: Add a new product
--
1. Navigate to /product-management
2. Fill form with required fields
3. Click "Add Product"
4. See confirmation snack bar
5. New product appears on dashboard

Task: Update product quantity
--
1. Navigate to /stock-update
2. Select product from dropdown
3. Choose "Stock In" or "Stock Out"
4. Enter quantity
5. Click "Update Stock"
6. See confirmation and verify in dashboard

Task: View transaction history
--
1. Navigate to /stock-history
2. See all transactions sorted by date
3. Color indicates type (green/red)
4. See optional notes

Task: Search for products
--
1. Navigate to /search-filter
2. Type in search bar
3. Results update in real-time
4. Can combine with category/status filters

Task: Filter by category
--
1. Navigate to /search-filter
2. Click category filter chip
3. Only products in that category appear
4. Can combine with search

Task: Filter by stock status
--
1. Navigate to /search-filter
2. Click status filter (Normal/Low/Critical)
3. Only products with that status appear
4. Red = out of stock, Orange = low, Green = normal

================================================================================
DEPENDENCIES SUMMARY
================================================================================

flutter_riverpod: ^2.4.8          - State management
riverpod_annotation: ^2.3.0       - Annotations for code gen

hive: ^2.2.3                      - Local storage
hive_flutter: ^1.1.0              - Flutter integration

firebase_core: ^2.24.0            - Firebase setup
cloud_firestore: ^4.13.0          - Realtime DB
firebase_auth: ^4.14.0            - Authentication

go_router: ^13.0.0                - Navigation

intl: ^0.19.0                     - Date/time formatting
cached_network_image: ^3.3.0      - Image caching

http: ^1.1.0                      - HTTP requests
uuid: ^4.0.0                      - ID generation
connectivity_plus: ^5.0.0         - Network state

riverpod_generator: ^2.3.7        - Code generation (dev)
build_runner: ^2.4.6              - Build tool (dev)
hive_generator: ^2.0.0            - Hive gen (dev)

================================================================================
GENERATED FILES (AUTO-CREATED)
================================================================================

After running: flutter pub run build_runner build

lib/models/product_model.g.dart
  - Hive adapter for ProductModel
  - Serialization code

lib/models/stock_entry_model.g.dart
  - Hive adapter for StockEntryModel
  - Serialization code

These are generated automatically, DO NOT EDIT manually.
If they don't appear, run: flutter pub run build_runner build --delete-conflicting-outputs

================================================================================
TROUBLESHOOTING QUICK FIX
================================================================================

App won't start:
  → Check main.dart initialization order
  → Verify Hive.initFlutter() before Hive.openBox()
  → Check build_runner ran successfully

Providers not updating:
  → Use ref.refresh() after state changes
  → Check provider has correct dependencies
  → Verify StateProvider vs FutureProvider usage

Compilation errors:
  → Run: flutter clean
  → Then: flutter pub get
  → Then: flutter pub run build_runner build

Type errors on models:
  → Regenerate: flutter pub run build_runner build
  → Check part statements in model files
  → Verify @HiveType decorators

Negative stock allowed:
  → Check StockEntryType.stockOut validation
  → Verify quantity >= available check
  → Look for missing validation in form

================================================================================
PERFORMANCE TIPS
================================================================================

1. Hive is already optimized, but for large lists:
   - Use ListView.builder instead of ListView

2. Riverpod caching:
   - Providers cache results automatically
   - Use ref.refresh() sparingly

3. Search:
   - Implement debouncing for large datasets
   - Use lowercase for case-insensitive search

4. UI:
   - Use const constructors where possible
   - Avoid rebuilding entire list on state change
   - Use PageView for heavy screens

================================================================================
RESOURCES
================================================================================

Flutter Documentation: https://flutter.dev/docs
Riverpod Documentation: https://riverpod.dev
Hive Documentation: https://docs.hivedb.dev
GoRouter Documentation: https://pub.dev/packages/go_router
Firebase Documentation: https://firebase.google.com/docs

================================================================================
