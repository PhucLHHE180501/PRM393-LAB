import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_flutter/main.dart';

void main() {
  testWidgets('Lab 4 app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const Lab4App());

    expect(find.text('Flutter UI Fundamentals'), findsOneWidget);
    expect(find.text('Exercise 1 - Core Widgets'), findsOneWidget);
    expect(find.text('Exercise 2 - Input Widgets'), findsOneWidget);
    expect(find.text('Exercise 3 - Layout'), findsOneWidget);
    expect(find.text('Exercise 4 - Scaffold & Theme'), findsOneWidget);
    expect(find.text('Exercise 5 - Debug & Fix'), findsOneWidget);
  });
}