import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter_lab1/main.dart';

void main() {
  test('runs the basic Dart exercises', () async {
    expect(basicSyntaxExercise(), contains('Name: Phuc'));
    expect(collectionsExercise(), contains('Map access: Dart = 10'));
    expect(controlFlowExercise(), contains('Day: Tuesday'));
    expect(oopExercise(), contains('Tesla is driving silently'));

    final asyncResults = await asyncExercise();
    expect(asyncResults, contains('Stream values: [1, 2, 3]'));
  });
}
