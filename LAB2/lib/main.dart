Future<void> main() async {
  print('=== Exercise 1: Basic Syntax & Data Types ===');
  basicSyntaxExercise();

  print('\n=== Exercise 2: Collections & Operators ===');
  collectionsExercise();

  print('\n=== Exercise 3: Control Flow & Functions ===');
  controlFlowExercise();

  print('\n=== Exercise 4: Intro to OOP ===');
  oopExercise();

  print('\n=== Exercise 5: Async, Future, Null Safety & Streams ===');
  await asyncExercise();
}

List<String> basicSyntaxExercise() {
  int age = 22;
  double height = 1.72;
  String name = 'Phuc';
  bool likesDart = true;

  final results = [
    'Name: $name',
    'Age: $age, height: ${height}m',
    'Likes Dart: $likesDart',
  ];
  results.forEach(print);
  return results;
}

List<String> collectionsExercise() {
  final numbers = <int>[1, 2, 3, 4];
  final sum = numbers[0] + numbers[1];
  final isLarger = sum > numbers[2] && numbers[3] == 4;
  final uniqueNumbers = <int>{1, 2, 3};
  uniqueNumbers.add(4);
  uniqueNumbers.remove(1);
  final scores = <String, int>{'Dart': 10, 'Flutter': 9};

  final results = [
    'List: $numbers, first item: ${numbers[0]}',
    '1 + 2 = $sum, comparison: $isLarger',
    'Set after add/remove: $uniqueNumbers',
    'Map access: Dart = ${scores['Dart']}',
  ];
  results.forEach(print);
  return results;
}

List<String> controlFlowExercise() {
  const score = 85;
  final grade = score >= 50 ? 'Pass' : 'Fail';
  const day = 2;
  final dayName = switch (day) {
    1 => 'Monday',
    2 => 'Tuesday',
    _ => 'Other day',
  };
  final results = <String>['Score: $score ($grade)', 'Day: $dayName'];

  for (var index = 0; index < 3; index++) {
    results.add('for: $index');
  }
  for (final number in [1, 2, 3]) {
    results.add('for-in: $number');
  }
  [4, 5].forEach((number) => results.add('forEach: $number'));
  results.add(greet('Dart'));
  results.add('Multiply: ${multiply(3, 4)}');
  results.forEach(print);
  return results;
}

String greet(String name) {
  return 'Hello, $name';
}

int multiply(int first, int second) => first * second;

class Car {
  final String brand;

  Car(this.brand);

  Car.fromBrand(String value) : brand = value;

  String drive() => '$brand is driving';
}

class ElectricCar extends Car {
  ElectricCar(super.brand);

  @override
  String drive() => '$brand is driving silently';
}

List<String> oopExercise() {
  final car = Car.fromBrand('Toyota');
  final electricCar = ElectricCar('Tesla');
  final results = [car.drive(), electricCar.drive()];
  results.forEach(print);
  return results;
}

Future<List<String>> asyncExercise() async {
  await Future<void>.delayed(const Duration(milliseconds: 50));
  String? nickname = DateTime.now().millisecond.isEven ? 'dart' : null;
  final optionalResult = nickname?.toUpperCase() ?? 'NO NICKNAME';
  String? loadedMessage = loadMessageValue();
  final confirmedMessage = loadedMessage!;
  final streamValues = <int>[];
  final subscription = Stream<int>.fromIterable([1, 2, 3]).listen(
    streamValues.add,
  );
  await subscription.asFuture<void>();
  loadedMessage = null;

  final results = [
    confirmedMessage,
    'Null-aware result: $optionalResult',
    'Stream values: $streamValues',
  ];
  results.forEach(print);
  return results;
}

String? loadMessageValue() => 'Data loaded';
