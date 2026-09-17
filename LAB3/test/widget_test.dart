import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter_lab3/main.dart';

void main() {
  test('Exercise 1 - Product Model & Repository', () async {
    final repository = ProductRepository();

    final products = await repository.getAll();

    expect(products.length, 3);
    expect(products[0].name, 'Laptop');
    expect(products[1].name, 'Mouse');
    expect(products[2].name, 'Keyboard');

    repository.dispose();
  });

  test('Exercise 2 - User Repository with JSON', () async {
    final repository = UserRepository();

    final users = await repository.getUsers();

    expect(users.length, 3);
    expect(users[0].name, 'John');
    expect(users[0].email, 'john@example.com');
    expect(users[1].name, 'Alice');
    expect(users[2].name, 'Bob');
  });

  test('Exercise 3 - Async + Microtask Debugging', () async {
    final results = <String>[];

    scheduleMicrotask(() {
      results.add('Microtask');
    });

    Future(() {
      results.add('Future');
    });

    results.add('Synchronous');

    await Future.delayed(Duration(milliseconds: 100));

    expect(
      results,
      equals([
        'Synchronous',
        'Microtask',
        'Future',
      ]),
    );
  });

  test('Exercise 4 - Stream Transformation', () async {
    final numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

    final results = await numbers
        .map((number) => number * number)
        .where((number) => number % 2 == 0)
        .toList();

    expect(results, equals([4, 16]));
  });

  test('Exercise 5 - Factory Constructors & Cache', () {
    final a = Settings();
    final b = Settings();

    expect(identical(a, b), true);
  });
}

