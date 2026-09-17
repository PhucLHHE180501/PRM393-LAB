import 'dart:async';
import 'dart:convert';

void main() async {
  print('===== EXERCISE 1 =====');
  await exercise1();

  print('\n===== EXERCISE 2 =====');
  await exercise2();

  print('\n===== EXERCISE 3 =====');
  await exercise3();

  print('\n===== EXERCISE 4 =====');
  await exercise4();

  print('\n===== EXERCISE 5 =====');
  exercise5();
}

class Product {
  final int id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
  }
}

class ProductRepository {
  final List<Product> _products = [
    Product(1, 'Laptop', 1200.0),
    Product(2, 'Mouse', 25.0),
    Product(3, 'Keyboard', 50.0),
  ];

  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _products;
  }

  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product);
  }

  void dispose() {
    _controller.close();
  }
}

Future<void> exercise1() async {
  final repository = ProductRepository();

  final products = await repository.getAll();

  print('All products:');
  for (final product in products) {
    print(product);
  }

  repository.liveAdded().listen((product) {
    print('New product added: $product');
  });

  repository.addProduct(Product(4, 'Headset', 80.0));

  await Future.delayed(Duration(milliseconds: 100));

  repository.dispose();
}


class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  @override
  String toString() {
    return 'User(name: $name, email: $email)';
  }
}

class UserRepository {
  Future<List<User>> getUsers() async {
    const jsonData = '''
    [
      {
        "name": "John",
        "email": "john@example.com"
      },
      {
        "name": "Alice",
        "email": "alice@example.com"
      },
      {
        "name": "Bob",
        "email": "bob@example.com"
      }
    ]
    ''';

    await Future.delayed(Duration(milliseconds: 300));

    final List<dynamic> data = jsonDecode(jsonData);

    return data
        .map((json) => User.fromJson(json))
        .toList();
  }
}

Future<void> exercise2() async {
  final repository = UserRepository();

  final users = await repository.getUsers();

  print('Users from JSON:');

  for (final user in users) {
    print(user);
  }
}


Future<void> exercise3() async {
  print('1. Start');

  scheduleMicrotask(() {
    print('3. Microtask');
  });

  Future(() {
    print('4. Future event');
  });

  print('2. End');

  await Future.delayed(Duration(milliseconds: 100));

  print('5. Microtasks run before Future event callbacks');
  print('Reason: Dart processes the microtask queue before '
      'moving to the event queue.');
}



Future<void> exercise4() async {
  final numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Even squares:');

  await numbers
      .map((number) => number * number)
      .where((number) => number % 2 == 0)
      .forEach((number) {
        print(number);
      });
}


class Settings {
  static final Settings _instance = Settings._internal();

  Settings._internal();

  factory Settings() {
    return _instance;
  }
}

void exercise5() {
  final a = Settings();
  final b = Settings();

  print('a and b refer to the same object:');
  print(identical(a, b));
}