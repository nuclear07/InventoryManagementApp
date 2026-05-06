================================================================================
COMPLETE FILE COPY-PASTE INSTRUCTIONS
Smart Inventory & Stock Replenishment App
================================================================================

This document provides the exact path and instructions for copying each file.

================================================================================
STEP 1: INITIAL SETUP
================================================================================

1. Create Flutter project:
   Command: flutter create --org com.example smart_inventory
   Navigate: cd smart_inventory

2. Project structure created:
   smart_inventory/
   ├── lib/
   │   └── main.dart (will be replaced)
   ├── test/
   ├── pubspec.yaml (will be replaced)
   ├── android/
   ├── ios/
   ├── web/
   └── windows/

================================================================================
STEP 2: COPY pubspec.yaml
================================================================================

File Location: smart_inventory/pubspec.yaml

Action: REPLACE the entire file

Source: SOURCE_CODE_PART1.txt line 1 onwards
After: "name: smart_inventory"
To: The line ending with "flutter:"

The file contains:
- Project name and version
- Flutter and Dart SDK requirements
- All package dependencies
- Dev dependencies for code generation

VERIFY: After copying, file should have ~75 lines and contain:
  - flutter_riverpod
  - hive
  - firebase_core
  - go_router

================================================================================
STEP 3: CREATE DIRECTORY STRUCTURE
================================================================================

Create these folders under smart_inventory/lib/:

1. models/
2. core/
3. core/constants/
4. core/theme/
5. core/utils/
6. data/
7. data/repositories/
8. providers/
9. presentation/
10. presentation/routes/
11. presentation/screens/
12. presentation/widgets/

You can create manually or using:
mkdir lib\models lib\core lib\core\constants lib\core\theme lib\core\utils lib\data lib\data\repositories lib\providers lib\presentation lib\presentation\routes lib\presentation\screens lib\presentation\widgets

================================================================================
STEP 4: COPY MODEL FILES
================================================================================

FILE 1: lib/models/product_model.dart
=====================================

File Path: smart_inventory/lib/models/product_model.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 2: lib/models/product_model.dart"

Copy from:
// COMMIT 1: Project Initialization — Product Model
import 'package:hive/hive.dart';

To:
}

Key Content:
- @HiveType(typeId: 0) class ProductModel
- ProductCategory enum (electronics, stationery, etc.)
- getStockStatus() method
- copyWith() method

VERIFY: File should have:
- part 'product_model.g.dart'; (generated later)
- @HiveField decorators
- StockStatus enum at end


FILE 2: lib/models/stock_entry_model.dart
==========================================

File Path: smart_inventory/lib/models/stock_entry_model.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 3: lib/models/stock_entry_model.dart"

Copy from:
// COMMIT 1: Project Initialization — Stock Entry Model
import 'package:hive/hive.dart';

To:
}

Key Content:
- @HiveType(typeId: 1) class StockEntryModel
- StockEntryType enum (stockIn, stockOut)
- formattedDate property
- typeLabel property

VERIFY: File should have:
- part 'stock_entry_model.g.dart';
- StockEntryType enum

================================================================================
STEP 5: COPY CORE FILES
================================================================================

FILE 3: lib/core/constants/app_constants.dart
==============================================

File Path: smart_inventory/lib/core/constants/app_constants.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 4: lib/core/constants/app_constants.dart"

Copy from:
// App Constants
class AppConstants {

To:
}

Key Content:
- Hive box names
- Route names
- Validation messages
- Category labels

VERIFY: Contains all constant strings used throughout app


FILE 4: lib/core/theme/app_theme.dart
======================================

File Path: smart_inventory/lib/core/theme/app_theme.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 5: lib/core/theme/app_theme.dart"

Copy from:
// COMMIT 2: UI Development — App Theme
import 'package:flutter/material.dart';

To:
}

Key Content:
- Material 3 ThemeData configuration
- Color constants (green, amber, red)
- getStockStatusColor() method
- AppBar and Button styling

VERIFY: File contains:
- lightTheme definition
- Color constants (normalStockColor, lowStockColor, criticalStockColor)


FILE 5: lib/core/utils/validators.dart
=======================================

File Path: smart_inventory/lib/core/utils/validators.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 6: lib/core/utils/validators.dart"

Copy from:
// Input Validators
class Validators {

To:
}

Key Content:
- validateProductName()
- validateQuantity()
- validateThreshold()
- validateStock()

VERIFY: All validation methods should return String? (error message or null)

================================================================================
STEP 6: COPY REPOSITORY FILES
================================================================================

FILE 6: lib/data/repositories/product_repository.dart
=====================================================

File Path: smart_inventory/lib/data/repositories/product_repository.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 7: lib/data/repositories/product_repository.dart"

Copy from:
// COMMIT 3: Core Logic — Product Repository
import 'package:hive/hive.dart';

To:
}

Key Content:
- addProduct() - Create new product
- updateProduct() - Modify existing
- deleteProduct() - Remove product
- getAllProducts() - Retrieve all
- searchProducts() - Filter by name
- getLowStockCount() - Count low stock
- getOutOfStockCount() - Count zero stock
- getRecentlyUpdated() - Recently modified

VERIFY: Class should be named ProductRepository


FILE 7: lib/data/repositories/stock_entry_repository.dart
==========================================================

File Path: smart_inventory/lib/data/repositories/stock_entry_repository.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 8: lib/data/repositories/stock_entry_repository.dart"

Copy from:
// COMMIT 3: Core Logic — Stock Entry Repository
import 'package:hive/hive.dart';

To:
}

Key Content:
- addStockEntry() - Record transaction
- getAllEntries() - Get all transactions
- getEntriesByProduct() - Filter by product
- getRecentEntries() - Get recent transactions
- deleteEntry() - Remove entry

VERIFY: Class should be named StockEntryRepository

================================================================================
STEP 7: COPY PROVIDER FILES
================================================================================

FILE 8: lib/providers/product_provider.dart
============================================

File Path: smart_inventory/lib/providers/product_provider.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 9: lib/providers/product_provider.dart"

Copy from:
// COMMIT 3: Core Logic — Product Provider (Riverpod)
import 'package:flutter_riverpod/flutter_riverpod.dart';

To:
}

Key Content:
- productRepositoryProvider
- allProductsProvider (FutureProvider)
- productsByCategoryProvider
- searchedProductsProvider
- productSearchProvider
- lowStockCountProvider
- outOfStockCountProvider
- recentlyUpdatedProductsProvider
- totalProductsCountProvider

VERIFY: All providers are properly defined with correct types


FILE 9: lib/providers/stock_provider.dart
==========================================

File Path: smart_inventory/lib/providers/stock_provider.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 10: lib/providers/stock_provider.dart"

Copy from:
// COMMIT 3: Core Logic — Stock Provider (Riverpod)
import 'package:flutter_riverpod/flutter_riverpod.dart';

To:
}

Key Content:
- stockEntryRepositoryProvider
- allStockEntriesProvider
- stockEntriesByProductProvider
- recentStockEntriesProvider
- updateStockProvider (FutureProvider with params)

VERIFY: Contains updateStockProvider which handles the core business logic

================================================================================
STEP 8: COPY ROUTING FILE
================================================================================

FILE 10: lib/presentation/routes/app_router.dart
================================================

File Path: smart_inventory/lib/presentation/routes/app_router.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 11: lib/presentation/routes/app_router.dart"

Copy from:
// COMMIT 2: UI Development — App Router
import 'package:flutter_riverpod/flutter_riverpod.dart';

To:
}

Key Content:
- appRouterProvider definition
- 5 GoRoutes for each screen
- Route paths: /, /product-management, /stock-update, /stock-history, /search-filter

VERIFY: All route paths match those used in app

================================================================================
STEP 9: COPY SCREEN FILES
================================================================================

FILE 11: lib/presentation/screens/dashboard_screen.dart
=======================================================

File Path: smart_inventory/lib/presentation/screens/dashboard_screen.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART2.txt
Search for: "FILE 12: lib/presentation/screens/dashboard_screen.dart"

Copy from:
// COMMIT 2: UI Development — Dashboard Screen
import 'package:flutter/material.dart';

To:
}

Key Content:
- DashboardScreen ConsumerStatefulWidget
- Summary cards (Total, Low Stock, Out of Stock)
- Product list with status badges
- Pull-to-refresh support
- FAB for adding products
- ProductListTile widget
- SummaryCard widget

VERIFY: Contains all 3 summary cards and product list


FILE 12: lib/presentation/screens/product_management_screen.dart
================================================================

File Path: smart_inventory/lib/presentation/screens/product_management_screen.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART2.txt
Search for: "FILE 13: lib/presentation/screens/product_management_screen.dart"

Copy from:
// COMMIT 2: UI Development — Product Management Screen
import 'package:flutter/material.dart';

To:
}

Key Content:
- ProductManagementScreen ConsumerStatefulWidget
- Displays ProductForm widget
- Handles add/edit product logic
- Success/error callbacks

VERIFY: Screen should accept optional productId for editing


FILE 13: lib/presentation/screens/stock_update_screen.dart
==========================================================

File Path: smart_inventory/lib/presentation/screens/stock_update_screen.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART2.txt
Search for: "FILE 14: lib/presentation/screens/stock_update_screen.dart"

Copy from:
// COMMIT 2: UI Development — Stock Update Screen
import 'package:flutter/material.dart';

To:
}

Key Content:
- StockUpdateScreen ConsumerStatefulWidget
- Product dropdown
- Segmented button for Stock In/Out
- Quantity input field
- Optional note field
- Negative stock validation
- Submit button with loading state

VERIFY: Contains validation preventing negative inventory


FILE 14: lib/presentation/screens/stock_history_screen.dart
===========================================================

File Path: smart_inventory/lib/presentation/screens/stock_history_screen.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART2.txt
Search for: "FILE 15: lib/presentation/screens/stock_history_screen.dart"

Copy from:
// COMMIT 2: UI Development — Stock History Screen
import 'package:flutter/material.dart';

To:
}

Key Content:
- StockHistoryScreen ConsumerWidget
- List of all stock entries
- Sorted by most recent first
- Color-coded by type (green/red)
- StockHistoryTile widget
- Empty state handling

VERIFY: Entries are sorted descending by date


FILE 15: lib/presentation/screens/search_filter_screen.dart
===========================================================

File Path: smart_inventory/lib/presentation/screens/search_filter_screen.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART2.txt
Search for: "FILE 16: lib/presentation/screens/search_filter_screen.dart"

Copy from:
// COMMIT 2: UI Development — Search & Filter Screen
import 'package:flutter/material.dart';

To:
}

Key Content:
- SearchFilterScreen ConsumerStatefulWidget
- SearchBar for text search
- Category filter chips
- Stock status filter chips (Normal, Low, Critical)
- Live result updating
- Product cards display

VERIFY: Filters work independently and can be combined

================================================================================
STEP 10: COPY WIDGET FILES
================================================================================

FILE 16: lib/presentation/widgets/stock_status_badge.dart
=========================================================

File Path: smart_inventory/lib/presentation/widgets/stock_status_badge.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART3.txt
Search for: "FILE 17: lib/presentation/widgets/stock_status_badge.dart"

Copy from:
// COMMIT 2: UI Development — Stock Status Badge Widget
import 'package:flutter/material.dart';

To:
}

Key Content:
- StockStatusBadge StatelessWidget
- Takes StockStatus enum as parameter
- Returns colored badge with icon
- Colors: Green (normal), Orange (low), Red (critical)

VERIFY: Badge displays correct color and icon for each status


FILE 17: lib/presentation/widgets/product_form.dart
===================================================

File Path: smart_inventory/lib/presentation/widgets/product_form.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART3.txt
Search for: "FILE 18: lib/presentation/widgets/product_form.dart"

Copy from:
// COMMIT 2: UI Development — Product Form Widget
import 'package:flutter/material.dart';

To:
}

Key Content:
- ProductForm StatefulWidget
- Form fields: name, category, quantity, threshold
- Add/Update/Delete logic
- Input validation using Validators
- Delete confirmation dialog
- Success/error handling

VERIFY: Form handles both create and edit modes


FILE 18: lib/presentation/widgets/empty_state_widget.dart
=========================================================

File Path: smart_inventory/lib/presentation/widgets/empty_state_widget.dart
Action: CREATE NEW FILE

Source Location: SOURCE_CODE_PART3.txt
Search for: "FILE 19: lib/presentation/widgets/empty_state_widget.dart"

Copy from:
// COMMIT 2: UI Development — Empty State Widget
import 'package:flutter/material.dart';

To:
}

Key Content:
- EmptyStateWidget StatelessWidget
- Icon display
- Title and message
- Optional action button
- Centered layout

VERIFY: Widget is reusable for all empty states

================================================================================
STEP 11: REPLACE main.dart
================================================================================

FILE 19: lib/main.dart
======================

File Path: smart_inventory/lib/main.dart
Action: REPLACE ENTIRE FILE (delete existing content first)

Source Location: SOURCE_CODE_PART1.txt
Search for: "FILE 1: lib/main.dart"

Copy from:
// COMMIT 1: Project Initialization — Main entry point
import 'package:flutter/material.dart';

To:
}

Key Content:
- main() function with async initialization
- Hive.initFlutter()
- Adapter registration
- Box opening
- ProviderScope wrapping
- SmartInventoryApp ConsumerWidget
- Material app with GoRouter configuration

VERIFY: File should NOT have any existing code from flutter create

================================================================================
STEP 12: CREATE .gitignore
================================================================================

FILE 20: .gitignore
===================

File Path: smart_inventory/.gitignore
Action: REPLACE ENTIRE FILE

Source Location: SOURCE_CODE_PART3.txt
Search for: "FILE 20: .gitignore"

Copy from:
# Miscellaneous
*.class

To:
# Exceptions to above rules.
!/packages/flutter_tools/test/data/dart_dependencies_test/**/.packages

Key Content:
- Flutter-specific ignores
- IDE ignores (.vscode, .idea)
- Build artifacts
- iOS/Android build files

VERIFY: File starts with "# Miscellaneous"

================================================================================
STEP 13: VERIFY FILE STRUCTURE
================================================================================

After copying all files, verify directory structure:

smart_inventory/
├── lib/
│   ├── main.dart ✓
│   ├── models/
│   │   ├── product_model.dart ✓
│   │   ├── stock_entry_model.dart ✓
│   │   ├── product_model.g.dart (generated)
│   │   └── stock_entry_model.g.dart (generated)
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_constants.dart ✓
│   │   ├── theme/
│   │   │   └── app_theme.dart ✓
│   │   └── utils/
│   │       └── validators.dart ✓
│   ├── data/
│   │   └── repositories/
│   │       ├── product_repository.dart ✓
│   │       └── stock_entry_repository.dart ✓
│   ├── providers/
│   │   ├── product_provider.dart ✓
│   │   └── stock_provider.dart ✓
│   └── presentation/
│       ├── routes/
│       │   └── app_router.dart ✓
│       ├── screens/
│       │   ├── dashboard_screen.dart ✓
│       │   ├── product_management_screen.dart ✓
│       │   ├── stock_update_screen.dart ✓
│       │   ├── stock_history_screen.dart ✓
│       │   └── search_filter_screen.dart ✓
│       └── widgets/
│           ├── stock_status_badge.dart ✓
│           ├── product_form.dart ✓
│           └── empty_state_widget.dart ✓
├── test/
├── pubspec.yaml ✓
├── .gitignore ✓
├── README.md
└── [other flutter files]

================================================================================
STEP 14: BUILD AND RUN
================================================================================

1. Install dependencies:
   Command: flutter pub get
   Location: Run in smart_inventory/ directory
   Wait for: ~5-10 minutes

2. Generate code:
   Command: flutter pub run build_runner build
   Wait for: Completion message
   Generated files appear in lib/models/

3. Run analysis:
   Command: flutter analyze
   Should show: No issues (or only warnings)

4. Run app:
   Command: flutter run
   Should display: App starting and loading

5. Test basic functionality:
   - App should load without errors
   - Dashboard should show empty state
   - FAB should navigate to add product
   - Add a product and verify it appears

================================================================================
STEP 15: GIT COMMITS
================================================================================

After verification, make 4 commits:

COMMIT 1: Project Initialization
  git add pubspec.yaml lib/models/ lib/core/ lib/main.dart
  git commit -m "COMMIT 1: Project Initialization..."

COMMIT 2: UI Development
  git add lib/presentation/
  git commit -m "COMMIT 2: UI Development..."

COMMIT 3: Core Logic
  git add lib/data/ lib/providers/
  git commit -m "COMMIT 3: Core Logic..."

COMMIT 4: Offline Storage
  git add .
  git commit -m "COMMIT 4: Offline Storage & Final Integration..."

================================================================================
TROUBLESHOOTING DURING COPY
================================================================================

Issue: File not created
  Solution: Check folder structure exists
            Verify file path is correct
            Try creating parent folders first

Issue: Syntax errors after pasting
  Solution: Check for incomplete copy
            Verify closing braces present
            Check file doesn't have extra content

Issue: Import errors
  Solution: Check all import statements are correct
            Verify package names match pubspec.yaml
            Make sure file names match import statements

Issue: Missing generated files
  Solution: Run: flutter pub run build_runner build
            Check for errors in terminal
            Regenerate if needed

================================================================================

Total Files to Copy: 20 files (plus 2 auto-generated)
Estimated Time: 30-45 minutes
Difficulty: Medium (mostly copy-paste, requires attention to detail)

READY TO BEGIN? Follow this guide step by step!

================================================================================
