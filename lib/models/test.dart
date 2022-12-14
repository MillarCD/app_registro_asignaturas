
class Test {
  int? id;
  String name;
  DateTime? date;
  double? calification;
  int courseId;
  
  Test({
    this.id,
    required this.name,
    this.date,
    this.calification,
    required this.courseId,
  });

  factory Test.fromMap(Map<String, dynamic> newTest) => Test(
    id: newTest['id'],
    name: newTest['name'],
    date: newTest['date'],
    calification: newTest['calification'],
    courseId: newTest['courseId'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'calification': calification,
      'courseId': courseId
    };
  }
}