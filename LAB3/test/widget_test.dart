import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter_lab3/main.dart';

void main() {
  testWidgets('shows Lab 3 advanced Dart results', (WidgetTester tester) async {
    await tester.pumpWidget(const Lab3App());

    expect(find.text('Lab 3 - Advanced Dart'), findsOneWidget);

    final results = await runExercises();
    expect(results, contains('=== Exercise 1: Product Model & Repository ==='));
    expect(results, contains('=== Exercise 5: Factory Constructors & Cache ==='));
    expect(results, contains('identical(a, b): true'));
  });
}
