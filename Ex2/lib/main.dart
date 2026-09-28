abstract class Employee {
  String name;

  Employee(this.name);

  void work();
}

// TODO 1: Mixin chỉ được sử dụng cho Employee
mixin CheckInAbility on Employee {
  void checkIn() {
    print("$name đã điểm danh");
  }
}

// TODO 2: Developer kế thừa Employee và sử dụng CheckInAbility
class Developer extends Employee with CheckInAbility {
  Developer(String name) : super(name);

  @override
  void work() => print("$name đang viết code.");
}

void main() {
  List<Developer> teamA = [
    Developer("An"),
    Developer("Bình")
  ];

  List<Developer> teamB = [
    Developer("Cường")
  ];

  // TODO 3: Dùng Spread Operator (...) để gộp 2 team
  List<Developer> allStaff = [
    ...teamA,
    ...teamB
  ];

  // TODO 4: Gọi checkIn() cho toàn bộ nhân viên
  for (var employee in allStaff) {
    employee.checkIn();
  }
}