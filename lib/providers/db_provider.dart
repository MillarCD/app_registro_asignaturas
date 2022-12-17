import 'package:asignaturas/models/course.dart';
import 'package:asignaturas/models/test.dart';
import 'package:asignaturas/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  Database? _database;
  static final DBProvider db = DBProvider();

  Future<Database> get database async {
    if (_database!=null) return _database!;

    await initDB();
    return _database!;
  }

  Future<void> initDB() async {
    final databasesPath = await getDatabasesPath();
    final String path = '$databasesPath/asignaturas.db';
  
    _database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE Courses (id INTEGER PRIMARY KEY, name TEXT)'
        );
        await db.execute(
          '''
              CREATE TABLE Tests (
                id INTEGER PRIMARY KEY,
                name TEXT,
                date TEXT,
                calification REAL,
                course_id INTEGER,
                FOREIGN KEY(course_id) REFERENCES Courses(id)
              )
          '''
        );
      }
    );
  }

  // COURSE QUERIES

  Future<List<Course>> getCourses() async {
    final Database db = await database;
    List res = await db.rawQuery('''
      SELECT * FROM Courses
    ''');
    return [...res.map((course) => Course.fromMap(course))];
  }

  Future<int> createCourse(Course newCourse) async {
    final Database db = await database;

    final int id = await db.rawInsert('''
      INSERT INTO Courses(name) VALUES("${newCourse.name}")
    ''');
    return id;
  }
  Future<void> updateNameCourse(String oldName, String newName) async {
    final Database db = await database;
    await db.rawUpdate('''
      UPDATE Courses SET name = "$newName" WHERE name = "$oldName"
    ''');
  }
  Future<void> deleteCourse(int id) async {
    final Database db = await database;
    await db.rawDelete('''
      DELETE FROM Courses WHERE id = $id
    ''');
    await db.rawDelete('''
      DELETE FROM Tests WHERE course_id=$id
    ''');
  }

  // TEST QUERIES

  Future<List<Test>> getTestsByCourse(int courseId) async {
    final Database db = await database;
    List res = await db.rawQuery('''
      SELECT * FROM Tests WHERE course_id=$courseId
    ''');
    List<Test> tests = [...res.map((test) {
      return Test(
        id: test['id'],
        name: test['name'],
        calification: test['calification'],
        date: test['date']!=null ? toDateTime(test['date']) : null,
        courseId: test['id'],
      );
    })];

    return tests;
  }

  Future<int> createTest(Test newTest, int courseId) async {
    final Database db = await database;

    final int id = await db.rawInsert('''
      INSERT INTO Tests(name, date, calification, course_id)VALUES(?,?,?,?)
    ''',[
      newTest.name, transformDate(newTest.date), newTest.calification, courseId
    ]);
    return id;
  }

  Future<void> updateTest(Test test) async {
    final Database db = await database;
    await db.rawUpdate('''
      UPDATE Tests SET name=?, calification=?, date=? WHERE id = ${test.id}
    ''',[
      test.name, test.calification, transformDate(test.date)
    ]);

  }

  Future<void> deleteTest(int id) async {
    final Database db = await database;
    await db.rawDelete('''
      DELETE FROM Tests WHERE id = $id
    ''');
  }

}