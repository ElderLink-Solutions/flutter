import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:elderlink_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login E2E Tests', () {
    testWidgets('successful login flow', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Verify we're on the login screen
      expect(find.text('Welcome to ElderLink'), findsOneWidget);
      expect(find.byKey(const Key('username_field')), findsOneWidget);
      expect(find.byKey(const Key('password_field')), findsOneWidget);
      expect(find.byKey(const Key('login_button')), findsOneWidget);

      // Enter valid credentials
      await tester.enterText(
        find.byKey(const Key('username_field')),
        'admin',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );
      await tester.pumpAndSettle();

      // Tap the login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Wait for navigation to complete (simulated API delay is 1 second)
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify successful login and navigation to home screen
      expect(find.text('Login Successful!'), findsOneWidget);
      expect(find.text('Welcome to ElderLink Dashboard'), findsOneWidget);
      expect(find.byKey(const Key('success_message')), findsOneWidget);
      expect(find.byKey(const Key('logout_button')), findsOneWidget);
    });

    testWidgets('failed login flow with invalid credentials',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Enter invalid credentials
      await tester.enterText(
        find.byKey(const Key('username_field')),
        'wronguser',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'wrongpass',
      );
      await tester.pumpAndSettle();

      // Tap the login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Wait for the API simulation to complete
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify error message is displayed
      expect(find.byKey(const Key('error_message')), findsOneWidget);
      expect(find.text('Invalid username or password'), findsOneWidget);

      // Verify we're still on the login screen
      expect(find.text('Welcome to ElderLink'), findsOneWidget);
    });

    testWidgets('form validation - empty username', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Leave username empty, enter password
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );
      await tester.pumpAndSettle();

      // Tap the login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Verify validation error is displayed
      expect(find.text('Please enter your username'), findsOneWidget);
    });

    testWidgets('form validation - empty password', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Enter username, leave password empty
      await tester.enterText(
        find.byKey(const Key('username_field')),
        'admin',
      );
      await tester.pumpAndSettle();

      // Tap the login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Verify validation error is displayed
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('logout flow', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Login first
      await tester.enterText(
        find.byKey(const Key('username_field')),
        'admin',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify we're on the home screen
      expect(find.text('Login Successful!'), findsOneWidget);

      // Tap logout button
      await tester.tap(find.byKey(const Key('logout_button')));
      await tester.pumpAndSettle();

      // Verify we're back on the login screen
      expect(find.text('Welcome to ElderLink'), findsOneWidget);
      expect(find.byKey(const Key('username_field')), findsOneWidget);
      expect(find.byKey(const Key('password_field')), findsOneWidget);
    });

    testWidgets('loading state during login', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Enter valid credentials
      await tester.enterText(
        find.byKey(const Key('username_field')),
        'admin',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );
      await tester.pumpAndSettle();

      // Tap the login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      // Verify loading indicator appears
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for login to complete
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify we've navigated to home screen
      expect(find.text('Login Successful!'), findsOneWidget);
    });
  });
}
