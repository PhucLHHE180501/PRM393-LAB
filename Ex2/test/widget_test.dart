import 'package:flutter_test/flutter_test.dart';

import 'package:quan_ly_nhan_vien/main.dart';

void main() {
  test('merges both teams with the spread operator', () {
    final teamA = <Developer>[Developer('An'), Developer('Bình')];
    final teamB = <Developer>[Developer('Cường')];
    final allStaff = [...teamA, ...teamB];

    expect(allStaff, hasLength(3));
    expect(allStaff.map((employee) => employee.name), [
      'An',
      'Bình',
      'Cường',
    ]);
  });

  test('Developer has the check-in ability', () {
    final employee = Developer('An');

    expect(employee, isA<CheckInAbility>());
  });
}
