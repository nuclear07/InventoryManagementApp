# Test Examples & Best Practices

This document provides examples and best practices for writing and running tests for the Smart Inventory app.

## Basic Test Structure

### Anatomy of a Test

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 1. Group related tests
  group('Feature/Component Name', () {
    
    // 2. Optional setup before each test
    setUp(() {
      // Initialize test data, mocks, etc.
    });

    // 3. Optional cleanup after each test
    tearDown(() {
      // Clean up resources
    });

    // 4. Write individual tests
    test('should do something', () {
      // Arrange: Set up test data
      final input = 'test';
      
      // Act: Perform the action
      final result = myFunction(input);
      
      // Assert: Verify the result
      expect(result, 'expected');
    });
  });
}
```

---

## Unit Test Examples

### Example 1: Testing a Simple Function

```dart
// Function to test
bool isValidEmail(String email) {
  return email.contains('@');
}

// Test
void main() {
  group('Email Validation', () {
    test('should return true for valid email', () {
      expect(isValidEmail('user@example.com'), true);
    });

    test('should return false for invalid email', () {
      expect(isValidEmail('invalid.email'), false);
    });
  });
}
```

### Example 2: Testing a Class

```dart
// Class to test
class Calculator {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
}

// Test
void main() {
  group('Calculator', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('should add two numbers correctly', () {
      expect(calculator.add(2, 3), 5);
    });

    test('should subtract two numbers correctly', () {
      expect(calculator.subtract(5, 3), 2);
    });
  });
}
```

### Example 3: Testing Data Models

```dart
// Model to test
class Product {
  final String id;
  final String name;
  final int quantity;

  Product({required this.id, required this.name, required this.quantity});
}

// Test
void main() {
  group('Product Model', () {
    test('should create product with correct values', () {
      final product = Product(
        id: '1',
        name: 'Laptop',
        quantity: 10,
      );

      expect(product.id, '1');
      expect(product.name, 'Laptop');
      expect(product.quantity, 10);
    });
  });
}
```

---

## Widget Test Examples

### Example 1: Testing Button Rendering

```dart
void main() {
  testWidgets('should render button with text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ElevatedButton(
            onPressed: () {},
            child: Text('Click Me'),
          ),
        ),
      ),
    );

    expect(find.text('Click Me'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
```

### Example 2: Testing User Interactions

```dart
void main() {
  testWidgets('should increment counter when button is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Text('0'), // Counter initially 0
              ElevatedButton(
                onPressed: () {},
                child: Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );

    // Initial state
    expect(find.text('0'), findsOneWidget);

    // Tap the button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Rebuild widget tree

    // Updated state
    expect(find.text('1'), findsOneWidget);
  });
}
```

### Example 3: Testing List Rendering

```dart
void main() {
  testWidgets('should render list of items', (WidgetTester tester) async {
    final items = ['Item 1', 'Item 2', 'Item 3'];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: items.map((item) => ListTile(title: Text(item))).toList(),
          ),
        ),
      ),
    );

    for (final item in items) {
      expect(find.text(item), findsOneWidget);
    }
  });
}
```

---

## Mocking Examples

### Example 1: Mocking a Simple Class

```dart
import 'package:mocktail/mocktail.dart';

class UserRepository {
  Future<User> getUser(String id) async {
    // API call
  }
}

// Mock
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  test('should fetch user data', () async {
    final mockRepo = MockUserRepository();
    
    // Set up mock behavior
    when(() => mockRepo.getUser('1')).thenAnswer(
      (_) async => User(id: '1', name: 'John'),
    );

    // Use mock
    final user = await mockRepo.getUser('1');
    
    // Verify
    expect(user.name, 'John');
    verify(() => mockRepo.getUser('1')).called(1);
  });
}
```

### Example 2: Mocking Multiple Calls

```dart
void main() {
  test('should handle multiple calls', () async {
    final mockRepo = MockUserRepository();
    
    // First call returns one result
    when(() => mockRepo.getUser('1')).thenAnswer(
      (_) async => User(id: '1', name: 'John'),
    );
    
    // Second call returns different result
    when(() => mockRepo.getUser('2')).thenAnswer(
      (_) async => User(id: '2', name: 'Jane'),
    );

    final user1 = await mockRepo.getUser('1');
    final user2 = await mockRepo.getUser('2');

    expect(user1.name, 'John');
    expect(user2.name, 'Jane');
  });
}
```

---

## Assertion Examples

### Common Assertions

```dart
// Equality
expect(value, 5);
expect(value, equals(5));

// Null checks
expect(value, isNull);
expect(value, isNotNull);

// Type checks
expect(value, isA<String>());
expect(value, isInstanceOf<List>());

// String checks
expect(text, contains('hello'));
expect(text, startsWith('hello'));
expect(text, endsWith('world'));
expect(text, matches(RegExp(r'\d+')));

// List/Collection checks
expect(list, hasLength(5));
expect(list, contains(item));
expect(list, isEmpty);
expect(list, isNotEmpty);

// Boolean checks
expect(value, isTrue);
expect(value, isFalse);

// Comparison
expect(value, greaterThan(5));
expect(value, lessThan(10));
expect(value, greaterThanOrEqualTo(5));

// Throws
expect(() => risky(), throws);
expect(() => risky(), throwsException);
expect(() => risky(), throwsA(isA<CustomException>()));
```

---

## Best Practices

### 1. Use Descriptive Test Names

```dart
// ❌ Bad
test('test product', () {});

// ✅ Good
test('should create product with valid data', () {});
test('should throw error when name is empty', () {});
```

### 2. Organize Tests with Groups

```dart
void main() {
  group('ProductRepository', () {
    group('addProduct', () {
      test('should save product', () {});
      test('should throw error on invalid data', () {});
    });

    group('getProduct', () {
      test('should return product by id', () {});
      test('should return null if not found', () {});
    });
  });
}
```

### 3. Use AAA Pattern (Arrange, Act, Assert)

```dart
test('should calculate total correctly', () {
  // Arrange
  final items = [100, 200, 300];
  
  // Act
  final total = items.reduce((a, b) => a + b);
  
  // Assert
  expect(total, 600);
});
```

### 4. Keep Tests Focused

```dart
// ❌ Bad - Tests multiple things
test('should validate and save', () {
  expect(validate(data), true);
  save(data);
  expect(getSaved(), data);
});

// ✅ Good - Tests one thing
test('should validate data', () {
  expect(validate(data), true);
});

test('should save data', () {
  save(data);
  expect(getSaved(), data);
});
```

### 5. Use Setup and Teardown

```dart
void main() {
  setUp(() {
    // Run before each test
    initializeTestData();
  });

  tearDown(() {
    // Run after each test
    cleanupTestData();
  });

  test('test 1', () {});
  test('test 2', () {});
}
```

### 6. Test Edge Cases

```dart
test('should handle edge cases', () {
  // Empty input
  expect(process(''), isEmpty);
  
  // Null input
  expect(process(null), isNull);
  
  // Large input
  expect(process('A' * 1000), isNotEmpty);
  
  // Special characters
  expect(process('!@#$%'), isNotEmpty);
});
```

### 7. Use Fixtures for Complex Test Data

```dart
// Create a fixture file: test/fixtures/sample_products.dart
final sampleProducts = [
  Product(id: '1', name: 'Laptop', quantity: 10),
  Product(id: '2', name: 'Mouse', quantity: 50),
  Product(id: '3', name: 'Keyboard', quantity: 30),
];

// Use in tests
import 'fixtures/sample_products.dart';

test('should filter products by name', () {
  final filtered = filterByName(sampleProducts, 'Laptop');
  expect(filtered, hasLength(1));
  expect(filtered.first.name, 'Laptop');
});
```

---

## Running Specific Tests

### Run Tests by File
```bash
flutter test test/product_model_test.dart
```

### Run Tests by Name Pattern
```bash
flutter test -k "ProductModel"
flutter test -k "should create"
```

### Run Single Test
```bash
flutter test test/product_model_test.dart -k "should create a product with valid data"
```

### Run Multiple Files
```bash
flutter test test/product_model_test.dart test/validators_test.dart
```

---

## Debugging Tests

### Print Debug Information
```dart
test('should debug', () {
  print('Debug message');
  debugPrint('Debug print');
  
  final result = compute();
  print('Result: $result');
  
  expect(result, isNotNull);
});
```

### Run with Verbose Output
```bash
flutter test -v
```

### Run with Debugging
```dart
test('should debug', () {
  debugger(); // Breakpoint in IDE
  final result = compute();
});
```

### Increase Timeout for Slow Tests
```dart
testWidgets('slow test', (WidgetTester tester) async {
  // Will wait up to 30 seconds
}, timeout: Timeout(Duration(seconds: 30)));
```

---

## Performance Tips

### 1. Cache Test Setup
```dart
setUp(() {
  // Create once
  testData = createTestData();
});

test('test 1', () {
  // Reuse testData
});
```

### 2. Use late Keyword
```dart
late ExpensiveObject expensiveObject;

setUp(() {
  expensiveObject = ExpensiveObject();
});
```

### 3. Avoid Unnecessary Pumps
```dart
// ❌ Bad - Pumps for every check
testWidgets('test', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  await tester.pump();
  expect(find.text('A'), findsOneWidget);
  await tester.pump();
  expect(find.text('B'), findsOneWidget);
});

// ✅ Good - Single pump
testWidgets('test', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  await tester.pump();
  expect(find.text('A'), findsOneWidget);
  expect(find.text('B'), findsOneWidget);
});
```

---

## Common Issues & Solutions

### Issue 1: Widget Not Found
```dart
// Problem
expect(find.text('Hello'), findsOneWidget);
// Solution
await tester.pump(); // Wait for widget to render
expect(find.text('Hello'), findsOneWidget);
```

### Issue 2: Timeout on Async Operations
```dart
// Problem
final result = await expensiveOperation();
// Solution
final result = await expensiveOperation().timeout(
  Duration(seconds: 10),
  onTimeout: () => throw TimeoutException(),
);
```

### Issue 3: Mock Not Working
```dart
// Problem
when(() => mock.method()).thenReturn(value);
// Solution
when(() => mock.method()).thenAnswer((_) async => value);
```

---

## Continuous Integration

### GitHub Actions Example

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v2
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.0.0'
      
      - run: flutter pub get
      
      - run: flutter analyze
      
      - run: flutter test
      
      - run: flutter test --coverage
```

---

## Summary

✅ **Best Practices Checklist**
- [ ] Use descriptive test names
- [ ] Organize with groups
- [ ] Follow AAA pattern
- [ ] Keep tests focused
- [ ] Test edge cases
- [ ] Use mocks for dependencies
- [ ] Clean up with tearDown
- [ ] Run tests regularly
- [ ] Maintain >80% coverage
- [ ] Document complex tests

✅ **Testing Tools**
- `flutter test` - Run tests
- `flutter test --watch` - Watch mode
- `flutter test --coverage` - Coverage
- Mocktail - Mocking
- Integration test - E2E testing

---

**Happy Testing! 🚀**
