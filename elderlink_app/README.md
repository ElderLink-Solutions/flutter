# ElderLink Login Application

This Flutter application demonstrates a simple login flow with end-to-end (E2E) integration tests.

## Features

- Login screen with username and password fields
- Form validation
- Simulated authentication
- Success screen after login
- Logout functionality
- Comprehensive E2E tests

## Login Credentials

For successful login, use:
- **Username**: `admin`
- **Password**: `password123`

## Project Structure

```
elderlink_app/
├── lib/
│   ├── main.dart                    # App entry point
│   └── screens/
│       └── login_screen.dart        # Login and Home screens
├── test/
│   └── widget_test.dart            # Widget tests
└── integration_test/
    └── login_test.dart             # E2E integration tests
```

## Running the Application

```bash
cd elderlink_app
flutter pub get
flutter run
```

## Running Tests

### Widget Tests
```bash
flutter test
```

### Integration Tests (E2E)
```bash
flutter test integration_test/login_test.dart
```

Or using specific device:
```bash
# For Chrome (web)
flutter test integration_test/login_test.dart -d chrome

# For Android
flutter test integration_test/login_test.dart -d android

# For iOS
flutter test integration_test/login_test.dart -d ios
```

## Test Coverage

The E2E tests cover the following scenarios:

1. **Successful Login Flow**: Tests login with valid credentials and navigation to home screen
2. **Failed Login Flow**: Tests login with invalid credentials and error message display
3. **Form Validation - Empty Username**: Verifies validation error when username is empty
4. **Form Validation - Empty Password**: Verifies validation error when password is empty
5. **Logout Flow**: Tests the complete login-logout cycle
6. **Loading State**: Verifies that loading indicator appears during authentication

## Building the Application

```bash
# For Android
flutter build apk

# For iOS
flutter build ios

# For Web
flutter build web
```

## Requirements

- Flutter SDK >= 2.19.4
- Dart SDK >= 2.19.4

## License

This is a demonstration project for ElderLink Solutions.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
