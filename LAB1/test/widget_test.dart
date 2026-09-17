import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:hello_flutter_lab1/main.dart';

void main() {
  testWidgets('shows the Lab 1 demo layout', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lab 1 Demo'), findsOneWidget);
    expect(find.text('Welcome to Flutter!'), findsOneWidget);
    expect(find.text('Your first customized layout 😊'), findsOneWidget);
    expect(find.byIcon(Icons.flutter_dash), findsOneWidget);
  });
}
