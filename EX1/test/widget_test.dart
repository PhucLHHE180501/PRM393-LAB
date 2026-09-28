// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:ex1/main.dart';

void main() {
  test('Car constructor creates a petrol car', () {
    final car = Car('Toyota', 2024, false);

    expect(car.brand, 'Toyota');
    expect(car.year, 2024);
    expect(car.isElectric, isFalse);
  });

  test('Car.tesla creates an electric Tesla', () {
    final tesla = Car.tesla(2026);

    expect(tesla.brand, 'Tesla');
    expect(tesla.year, 2026);
    expect(tesla.isElectric, isTrue);
  });
}