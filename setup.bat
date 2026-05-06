@echo off
REM Smart Inventory App - Complete Setup Script for Windows
REM This script creates the entire Flutter project structure and files

setlocal enabledelayedexpansion

echo.
echo ============================================
echo Smart Inventory App - Project Setup
echo ============================================
echo.

REM Create main directories
echo [1/3] Creating directory structure...
mkdir lib\models 2>nul
mkdir lib\core\constants 2>nul
mkdir lib\core\theme 2>nul
mkdir lib\core\utils 2>nul
mkdir lib\data\repositories 2>nul
mkdir lib\providers 2>nul
mkdir lib\presentation\routes 2>nul
mkdir lib\presentation\screens 2>nul
mkdir lib\presentation\widgets 2>nul

echo [2/3] Project structure created!

echo [3/3] Ready to generate source files...
echo.
echo ✅ Directory structure is ready!
echo.
echo NEXT STEPS:
echo 1. Run: flutter pub get
echo 2. Create all .dart files from the provided source code
echo 3. Run: flutter pub run build_runner build
echo 4. Run: flutter run
echo.
echo Files to create (copy content from below):
echo - lib\main.dart
echo - lib\models\product_model.dart
echo - lib\models\stock_entry_model.dart
echo - lib\core\theme\app_theme.dart
echo - lib\core\constants\app_constants.dart
echo - lib\core\utils\validators.dart
echo - lib\data\repositories\product_repository.dart
echo - lib\data\repositories\stock_entry_repository.dart
echo - lib\providers\product_provider.dart
echo - lib\providers\stock_provider.dart
echo - lib\presentation\routes\app_router.dart
echo - lib\presentation\screens\dashboard_screen.dart
echo - lib\presentation\screens\product_management_screen.dart
echo - lib\presentation\screens\stock_update_screen.dart
echo - lib\presentation\screens\stock_history_screen.dart
echo - lib\presentation\screens\search_filter_screen.dart
echo - lib\presentation\widgets\stock_status_badge.dart
echo - lib\presentation\widgets\product_form.dart
echo - lib\presentation\widgets\empty_state_widget.dart
echo.

pause
