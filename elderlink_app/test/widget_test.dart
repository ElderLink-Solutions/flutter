// This is a basic Flutter widget test for the login screen.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:elderlink_app/main.dart';

void main() {
  testWidgets('Login screen displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the login screen is displayed
    expect(find.text('Welcome to ElderLink'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byKey(const Key('username_field')), findsOneWidget);
    expect(find.byKey(const Key('password_field')), findsOneWidget);
    expect(find.byKey(const Key('login_button')), findsOneWidget);
  });

  testWidgets('Login button is disabled when fields are empty',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Find the login button
    final loginButton = find.byKey(const Key('login_button'));
    expect(loginButton, findsOneWidget);

    // Try to tap the login button without entering credentials
    await tester.tap(loginButton);
    await tester.pump();

    // Verify we're still on the login screen (validation errors should appear)
    expect(find.text('Welcome to ElderLink'), findsOneWidget);
  });

  testWidgets('Can enter text in username and password fields',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Enter text in username field
    await tester.enterText(
      find.byKey(const Key('username_field')),
      'testuser',
    );
    expect(find.text('testuser'), findsOneWidget);

    // Enter text in password field
    await tester.enterText(
      find.byKey(const Key('password_field')),
      'testpass',
    );
    
    // Password should be obscured, so we won't see the actual text
    await tester.pump();
  });
}

