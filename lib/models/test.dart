
class Test {
  int? id;
  String name;
  DateTime? date;
  double? calification;
  
  Test({
    this.id,
    required this.name,
    this.date,
    this.calification
  });

  factory Test.fromMap(Map<String, dynamic> newTest) => Test(
    id: newTest['id'],
    name: newTest['name'],
    date: newTest['date'],
    calification: newTest['calification']
  );
}