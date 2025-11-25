# Testing Guide

This document provides detailed information about the testing strategy and implementation for the ElderLink Login Application.

## Test Architecture

The application includes two levels of testing:

### 1. Widget Tests (`test/widget_test.dart`)
Unit-level tests that verify individual widgets work correctly in isolation.

**What is tested:**
- Login screen renders correctly
- Form fields are present and functional
- User can enter text in username and password fields
- Validation behavior

**Run with:**
```bash
flutter test test/widget_test.dart
```

### 2. Integration Tests (`integration_test/login_test.dart`)
End-to-end tests that simulate real user interactions with the application.

**What is tested:**
1. **Successful Login Flow**
   - User enters valid credentials (admin/password123)
   - Loading state appears during authentication
   - User is navigated to home screen
   - Success message is displayed

2. **Failed Login Flow**
   - User enters invalid credentials
   - Error message is displayed
   - User remains on login screen

3. **Form Validation**
   - Empty username validation
   - Empty password validation

4. **Logout Flow**
   - User logs in successfully
   - User clicks logout button
   - User is returned to login screen

5. **Loading State**
   - Loading indicator appears during authentication
   - Button is disabled during loading

**Run with:**
```bash
flutter test integration_test/login_test.dart
```

## Test Data

### Valid Credentials
- Username: `admin`
- Password: `password123`

### Invalid Credentials
- Any other username/password combination will fail

## Running Tests

### Quick Start
Use the provided script to run all tests:
```bash
cd elderlink_app
./run_tests.sh
```

### Manual Testing

#### Widget Tests Only
```bash
flutter test
```

#### Integration Tests Only
```bash
flutter test integration_test/
```

#### Specific Test File
```bash
flutter test integration_test/login_test.dart
```

#### With Coverage
```bash
flutter test --coverage
```

#### On Specific Device
```bash
# Web
flutter test integration_test/login_test.dart -d chrome

# Android
flutter test integration_test/login_test.dart -d android

# iOS  
flutter test integration_test/login_test.dart -d ios
```

## Test Keys

The application uses specific keys for testing purposes:

- `username_field` - Username text input
- `password_field` - Password text input
- `login_button` - Login submit button
- `error_message` - Error message text
- `success_message` - Success message on home screen
- `logout_button` - Logout button on home screen

## Understanding Test Output

### Successful Test Run
```
00:00 +0: Login E2E Tests successful login flow
00:02 +1: Login E2E Tests failed login flow with invalid credentials
00:04 +2: Login E2E Tests form validation - empty username
...
00:10 +6: All tests passed!
```

### Failed Test Run
```
00:00 +0: Login E2E Tests successful login flow
00:02 +0 -1: Login E2E Tests successful login flow [E]
  Expected: exactly one matching node in the widget tree
  Actual: _TextFinder:<zero widgets with text "Login Successful!" ...>
```

## Troubleshooting

### Common Issues

**Issue: Tests fail to start**
- Ensure Flutter is installed: `flutter doctor`
- Update dependencies: `flutter pub get`

**Issue: "No device found"**
- For integration tests on physical devices, ensure device is connected
- For web tests, ensure Chrome is installed
- Use `-d <device_id>` to specify device

**Issue: Tests timeout**
- Increase timeout in test file
- Check that simulated delays match expectations (current: 1 second)

**Issue: Widget not found**
- Verify widget keys are correctly set
- Use `await tester.pumpAndSettle()` to wait for animations

## Continuous Integration

For CI/CD pipelines:

```bash
# Install dependencies
flutter pub get

# Analyze code
flutter analyze

# Run widget tests
flutter test --no-pub

# Run integration tests (headless)
flutter test integration_test/ --no-pub -d web-server
```

## Adding New Tests

### Widget Test Template
```dart
testWidgets('Test description', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Your test assertions here
  expect(find.text('Something'), findsOneWidget);
});
```

### Integration Test Template
```dart
testWidgets('Test description', (WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();
  
  // Perform actions
  await tester.tap(find.byKey(const Key('some_button')));
  await tester.pumpAndSettle();
  
  // Verify results
  expect(find.text('Expected result'), findsOneWidget);
});
```

## Best Practices

1. **Use Keys**: Always add keys to interactive widgets for reliable testing
2. **Pump and Settle**: Use `pumpAndSettle()` after interactions to wait for animations
3. **Clear Test Data**: Reset state between tests to avoid interference
4. **Test Independently**: Each test should be able to run in isolation
5. **Descriptive Names**: Use clear, descriptive test names
6. **Test Real Scenarios**: Focus on user workflows, not just code coverage

## Coverage Report

To generate and view coverage:

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Additional Resources

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [Integration Testing Guide](https://flutter.dev/docs/testing/integration-tests)
- [Widget Testing Guide](https://flutter.dev/docs/cookbook/testing/widget/introduction)
