# Testing Guide for Smart Inventory App

This document provides comprehensive information about testing the Smart Inventory & Stock Replenishment app.

## Test Structure

```
test/
├── product_model_test.dart       # Unit tests for ProductModel
├── stock_entry_model_test.dart   # Unit tests for StockEntryModel
├── validators_test.dart          # Unit tests for validation functions
├── widgets_test.dart             # Widget tests for UI components
└── widget_test.dart              # Default Flutter widget test
```

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/product_model_test.dart
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Run Tests with Verbose Output
```bash
flutter test -v
```

## Test Categories

### 1. Unit Tests

#### ProductModel Tests (`product_model_test.dart`)
- ✅ Product creation with valid data
- ✅ Stock status detection (NORMAL, LOW, CRITICAL)
- ✅ Product property updates via copyWith
- ✅ All product categories support

**Run:**
```bash
flutter test test/product_model_test.dart
```

#### StockEntryModel Tests (`stock_entry_model_test.dart`)
- ✅ Stock entry creation
- ✅ Stock In/Out type identification
- ✅ Date formatting
- ✅ Optional notes handling
- ✅ Timestamp tracking

**Run:**
```bash
flutter test test/stock_entry_model_test.dart
```

#### Validators Tests (`validators_test.dart`)
- ✅ Product name validation (2-100 characters)
- ✅ Quantity validation (non-negative integers)
- ✅ Threshold validation
- ✅ Stock quantity validation (positive integers)

**Run:**
```bash
flutter test test/validators_test.dart
```

### 2. Widget Tests

#### Widget Component Tests (`widgets_test.dart`)
- ✅ StockStatusBadge rendering
- ✅ Status color coding
- ✅ Multiple widgets in layout

**Run:**
```bash
flutter test test/widgets_test.dart
```

## Test Results Interpretation

### Successful Test Output
```
00:00 +7: All tests passed!
```

### Failed Test Output
```
00:00 -1: Some tests failed.
Error: Expected X but got Y
```

## Code Coverage

To generate and view code coverage reports:

```bash
# Generate coverage report
flutter test --coverage

# View coverage report
# The coverage data is in coverage/lcov.info
```

### Coverage Tools (Optional)

For visual coverage reports, install `lcov`:

**macOS:**
```bash
brew install lcov
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

**Ubuntu/Debian:**
```bash
sudo apt-get install lcov
genhtml coverage/lcov.info -o coverage/html
```

**Windows:** Use LCOV tools or view coverage/lcov.info directly

## Test Checklist

- [ ] Run `flutter test` - all tests pass
- [ ] No analyzer warnings: `flutter analyze`
- [ ] Test coverage > 70%
- [ ] All features have corresponding tests
- [ ] Edge cases are covered
- [ ] Error scenarios are tested

## What's Currently Tested

### ✅ Models (26 tests)
- ProductModel creation and properties
- StockEntryModel creation and properties
- Stock status detection
- Data serialization

### ✅ Validators (15+ tests)
- Product name validation
- Quantity validation
- Threshold validation
- Stock quantity validation
- Error message generation

### ✅ Widgets (5+ tests)
- Widget rendering
- Status display
- Color coding
- Layout integration

## What Could Be Added

### Future Testing

1. **Provider Tests** - Test Riverpod providers with mocking
2. **Repository Tests** - Mock Hive boxes and test CRUD operations
3. **Integration Tests** - Test full user flows
4. **Screen Tests** - Test screen rendering and interactions
5. **Performance Tests** - Test app performance under load

### Adding Provider Tests

Example structure for provider tests:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_inventory/providers/product_provider.dart';

void main() {
  test('products provider should load products', () async {
    final container = ProviderContainer();
    // Test provider logic
  });
}
```

### Adding Repository Tests

Example with mocking:
```dart
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';

class MockBox extends Mock implements Box<ProductModel> {}

void main() {
  test('should save product to repository', () {
    final mockBox = MockBox();
    when(() => mockBox.add(any())).thenAnswer((_) async => 0);
    // Test repository methods
  });
}
```

## Troubleshooting

### Tests Not Found
```bash
# Ensure test files are in the test/ directory
# Ensure files end with _test.dart
flutter test --verbose
```

### Import Errors
```bash
# Regenerate build files
flutter pub run build_runner build
flutter test
```

### Timeout Issues
```bash
# Increase timeout for slow tests
flutter test --timeout=30s
```

### Coverage Report Generation Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter test --coverage
```

## Best Practices

1. **Organize Tests** - Group related tests with `group()`
2. **Use Descriptive Names** - Test names should describe what they test
3. **Keep Tests Focused** - Each test should verify one behavior
4. **Use Assertions** - Use specific assertions (not just `expect(x, true)`)
5. **Mock External Dependencies** - Use `mocktail` for mocking
6. **Test Edge Cases** - Include boundary conditions
7. **Clean Up** - Clean up resources after tests

## Running Tests in CI/CD

For GitHub Actions or similar CI/CD:

```yaml
- name: Run tests
  run: flutter test
```

For coverage reporting:

```yaml
- name: Generate coverage
  run: flutter test --coverage
  
- name: Upload coverage
  uses: codecov/codecov-action@v3
  with:
    files: ./coverage/lcov.info
```

## Quick Commands Reference

```bash
# Run all tests
flutter test

# Run specific file
flutter test test/product_model_test.dart

# Run with coverage
flutter test --coverage

# Run with verbose output
flutter test -v

# Run single test
flutter test -k "should create a product"

# Run tests with timeout
flutter test --timeout=60s

# Run tests and exit (CI mode)
flutter test --reporter=json > test-results.json
```

## Test Documentation Links

- [Flutter Testing Guide](https://flutter.dev/docs/testing)
- [Flutter Test API](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
- [Unit Testing](https://flutter.dev/docs/testing/unit-testing)
- [Widget Testing](https://flutter.dev/docs/testing/widget-testing)
- [Integration Testing](https://flutter.dev/docs/testing/integration-testing)
- [Mocktail Package](https://pub.dev/packages/mocktail)

---

**Last Updated:** May 6, 2026
**Test Framework:** Flutter Test
**Mocking Library:** Mocktail
**Coverage Tool:** LCOV (optional)
