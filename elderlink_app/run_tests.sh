#!/bin/bash

# ElderLink Login App Test Runner
# This script helps run the Flutter application tests

set -e

echo "================================================"
echo "ElderLink Login App - Test Runner"
echo "================================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    echo "Please install Flutter from: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter detected"
flutter --version
echo ""

# Navigate to the app directory
cd "$(dirname "$0")"

echo "📦 Getting dependencies..."
flutter pub get
echo ""

echo "🔍 Running static analysis..."
flutter analyze
echo ""

echo "🧪 Running widget tests..."
flutter test
echo ""

echo "🚀 Running integration tests..."
flutter test integration_test/
echo ""

echo "================================================"
echo "✅ All tests completed successfully!"
echo "================================================"
echo ""
echo "To run the app:"
echo "  flutter run"
echo ""
echo "To run specific tests:"
echo "  flutter test test/widget_test.dart"
echo "  flutter test integration_test/login_test.dart"
echo ""
