#!/bin/bash

# Smart Inventory App - Test Runner Script
# This script helps run tests and generate coverage reports

set -e

echo "================================================"
echo "Smart Inventory App - Test Runner"
echo "================================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

# Parse command line arguments
case "${1:-all}" in
    all)
        echo "Running all tests..."
        flutter test
        print_status "All tests completed"
        ;;
    
    unit)
        echo "Running unit tests..."
        flutter test test/product_model_test.dart test/stock_entry_model_test.dart test/validators_test.dart test/repository_pattern_test.dart
        print_status "Unit tests completed"
        ;;
    
    widget)
        echo "Running widget tests..."
        flutter test test/widgets_test.dart
        print_status "Widget tests completed"
        ;;
    
    coverage)
        echo "Generating test coverage report..."
        flutter test --coverage
        print_status "Coverage report generated"
        echo "Coverage data: coverage/lcov.info"
        ;;
    
    watch)
        echo "Running tests in watch mode..."
        flutter test --watch
        ;;
    
    verbose)
        echo "Running tests with verbose output..."
        flutter test -v
        ;;
    
    product)
        echo "Running ProductModel tests..."
        flutter test test/product_model_test.dart -v
        ;;
    
    stock)
        echo "Running StockEntryModel tests..."
        flutter test test/stock_entry_model_test.dart -v
        ;;
    
    validate)
        echo "Running Validators tests..."
        flutter test test/validators_test.dart -v
        ;;
    
    repository)
        echo "Running Repository pattern tests..."
        flutter test test/repository_pattern_test.dart -v
        ;;
    
    clean)
        echo "Cleaning test cache..."
        flutter clean
        flutter pub get
        print_status "Clean completed"
        ;;
    
    help)
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  all         - Run all tests (default)"
        echo "  unit        - Run unit tests only"
        echo "  widget      - Run widget tests only"
        echo "  coverage    - Generate coverage report"
        echo "  watch       - Run tests in watch mode"
        echo "  verbose     - Run tests with verbose output"
        echo "  product     - Run ProductModel tests"
        echo "  stock       - Run StockEntryModel tests"
        echo "  validate    - Run Validators tests"
        echo "  repository  - Run Repository tests"
        echo "  clean       - Clean and rebuild"
        echo "  help        - Show this help message"
        echo ""
        echo "Examples:"
        echo "  $0 unit"
        echo "  $0 coverage"
        echo "  $0 watch"
        ;;
    
    *)
        print_error "Unknown command: $1"
        echo "Run '$0 help' for usage information"
        exit 1
        ;;
esac

echo ""
echo "================================================"
print_status "Done!"
echo "================================================"
