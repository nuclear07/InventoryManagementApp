@echo off
REM Smart Inventory App - Test Runner Script (Windows)
REM This script helps run tests and generate coverage reports

setlocal enabledelayedexpansion

echo.
echo ================================================
echo Smart Inventory App - Test Runner
echo ================================================
echo.

REM Parse command line arguments
if "%1%"=="" (
    set "command=all"
) else (
    set "command=%1%"
)

REM Execute commands
if "%command%"=="all" (
    echo Running all tests...
    call flutter test
    echo.
    echo [SUCCESS] All tests completed
    goto :end
)

if "%command%"=="unit" (
    echo Running unit tests...
    call flutter test test\product_model_test.dart test\stock_entry_model_test.dart test\validators_test.dart test\repository_pattern_test.dart
    echo.
    echo [SUCCESS] Unit tests completed
    goto :end
)

if "%command%"=="widget" (
    echo Running widget tests...
    call flutter test test\widgets_test.dart
    echo.
    echo [SUCCESS] Widget tests completed
    goto :end
)

if "%command%"=="coverage" (
    echo Generating test coverage report...
    call flutter test --coverage
    echo.
    echo [SUCCESS] Coverage report generated
    echo Coverage data: coverage\lcov.info
    goto :end
)

if "%command%"=="watch" (
    echo Running tests in watch mode...
    call flutter test --watch
    goto :end
)

if "%command%"=="verbose" (
    echo Running tests with verbose output...
    call flutter test -v
    goto :end
)

if "%command%"=="product" (
    echo Running ProductModel tests...
    call flutter test test\product_model_test.dart -v
    goto :end
)

if "%command%"=="stock" (
    echo Running StockEntryModel tests...
    call flutter test test\stock_entry_model_test.dart -v
    goto :end
)

if "%command%"=="validate" (
    echo Running Validators tests...
    call flutter test test\validators_test.dart -v
    goto :end
)

if "%command%"=="repository" (
    echo Running Repository pattern tests...
    call flutter test test\repository_pattern_test.dart -v
    goto :end
)

if "%command%"=="clean" (
    echo Cleaning test cache...
    call flutter clean
    call flutter pub get
    echo.
    echo [SUCCESS] Clean completed
    goto :end
)

if "%command%"=="help" (
    echo Usage: run_tests.bat [command]
    echo.
    echo Commands:
    echo   all         - Run all tests (default)
    echo   unit        - Run unit tests only
    echo   widget      - Run widget tests only
    echo   coverage    - Generate coverage report
    echo   watch       - Run tests in watch mode
    echo   verbose     - Run tests with verbose output
    echo   product     - Run ProductModel tests
    echo   stock       - Run StockEntryModel tests
    echo   validate    - Run Validators tests
    echo   repository  - Run Repository tests
    echo   clean       - Clean and rebuild
    echo   help        - Show this help message
    echo.
    echo Examples:
    echo   run_tests.bat unit
    echo   run_tests.bat coverage
    echo   run_tests.bat watch
    goto :end
)

echo [ERROR] Unknown command: %command%
echo Run 'run_tests.bat help' for usage information
exit /b 1

:end
echo.
echo ================================================
echo [SUCCESS] Done!
echo ================================================
echo.
