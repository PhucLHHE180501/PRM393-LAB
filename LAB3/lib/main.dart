// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const Lab3App());
}

class Product {
  final int id;
  final String name;
  final double price;

  const Product({required this.id, required this.name, required this.price});

  @override
  String toString() => '#$id $name - \$${price.toStringAsFixed(2)}';
}

class ProductRepository {
  final StreamController<Product> _addedController =
      StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const [
      Product(id: 1, name: 'Keyboard', price: 49.99),
      Product(id: 2, name: 'Mouse', price: 24.50),
    ];
  }

  Stream<Product> liveAdded() => _addedController.stream;

  void add(Product product) {
    _addedController.add(product);
  }

  Future<void> dispose() => _addedController.close();
}

class User {
  final String name;
  final String email;

  const User({required this.name, required this.email});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        email = json['email'] as String;

  @override
  String toString() => '$name <$email>';
}

Future<List<User>> loadUsers() async {
  const jsonResponse = '''[
    {"name":"Alice","email":"alice@example.com"},
    {"name":"Bob","email":"bob@example.com"}
  ]''';
  await Future<void>.delayed(const Duration(milliseconds: 150));
  final decoded = jsonDecode(jsonResponse) as List<dynamic>;
  return decoded
      .map((item) => User.fromJson(item as Map<String, dynamic>))
      .toList();
}

Future<List<String>> microtaskExercise() async {
  final order = <String>[];
  scheduleMicrotask(() {
    order.add('microtask');
    print('Microtask callback');
  });
  Future<void>(() {
    order.add('event');
    print('Future event callback');
  });
  order.add('synchronous');
  print('Synchronous code');
  await Future<void>.delayed(Duration.zero);
  print('Execution order: $order');
  return order;
}

Stream<int> squaredEvenNumbers() => Stream.fromIterable([1, 2, 3, 4, 5])
    .map((number) => number * number)
    .where((number) => number.isEven);

class Settings {
  static Settings? _instance;

  Settings._();

  factory Settings() => _instance ??= Settings._();
}

Future<List<String>> runExercises() async {
  final output = <String>[];
  void record(String message) {
    output.add(message);
    print(message);
  }

  record('=== Exercise 1: Product Model & Repository ===');
  final repository = ProductRepository();
  final products = await repository.getAll();
  record('Products loaded: ${products.join(', ')}');
  final liveSubscription = repository.liveAdded().listen((product) {
    record('Live product added: $product');
  });
  repository.add(const Product(id: 3, name: 'Monitor', price: 199.99));
  await Future<void>.delayed(Duration.zero);
  await liveSubscription.cancel();
  await repository.dispose();

  record('=== Exercise 2: User Repository with JSON ===');
  final users = await loadUsers();
  record('Parsed users: ${users.join(', ')}');

  record('=== Exercise 3: Async + Microtask Debugging ===');
  final order = await microtaskExercise();
  record('Microtasks run before event callbacks: ${order.join(' -> ')}');

  record('=== Exercise 4: Stream Transformation ===');
  final squares = <int>[];
  await for (final square in squaredEvenNumbers()) {
    squares.add(square);
    record('Even square emitted: $square');
  }
  record('Even squares: $squares');

  record('=== Exercise 5: Factory Constructors & Cache ===');
  final firstSettings = Settings();
  final secondSettings = Settings();
  record('identical(a, b): ${identical(firstSettings, secondSettings)}');

  return output;
}

class Lab3App extends StatelessWidget {
  const Lab3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const Lab3HomePage(),
    );
  }
}

class Lab3HomePage extends StatefulWidget {
  const Lab3HomePage({super.key});

  @override
  State<Lab3HomePage> createState() => _Lab3HomePageState();
}

class _Lab3HomePageState extends State<Lab3HomePage> {
  late Future<List<String>> _exerciseFuture;

  @override
  void initState() {
    super.initState();
    _exerciseFuture = runExercises();
  }

  void _runAgain() {
    setState(() {
      _exerciseFuture = runExercises();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 3 - Advanced Dart'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            tooltip: 'Run exercises again',
            onPressed: _runAgain,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _exerciseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final lines = snapshot.data ?? const <String>[];
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lines.length,
            itemBuilder: (context, index) {
              final line = lines[index];
              final isHeading = line.startsWith('===');
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  line,
                  style: TextStyle(
                    fontSize: isHeading ? 18 : 15,
                    fontWeight: isHeading ? FontWeight.bold : FontWeight.normal,
                    color: isHeading
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _runAgain,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Run all'),
      ),
    );
  }
}
