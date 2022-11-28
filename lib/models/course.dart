
class Course {
  int? id;
  String name;

  Course({this.id, required this.name});

  factory Course.fromMap(Map<String, dynamic> newCourse) => Course(
    id: newCourse['id'],
    name: newCourse['name']
  );
}