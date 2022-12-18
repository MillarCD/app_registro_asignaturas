import 'package:asignaturas/providers/db_provider.dart';
import 'package:flutter/material.dart';

import 'package:asignaturas/models/test.dart';
import 'package:asignaturas/models/course.dart';

class CoursesProvider extends ChangeNotifier {
  List<Course> courses = [];
  List<Test> tests = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _currentCourseName = "";
  set currentCourseName(String courseName) {
    _currentCourseName = courseName;
    notifyListeners();
  }
  String get currentCourseName => _currentCourseName;

  CoursesProvider() {
    loadCourses();
  }

  Future<void> loadCourses() async {
    _isLoading = true;
    notifyListeners();
    // Carga los cursos de la base de datos y los recopila en courses
    courses = await DBProvider.db.getCourses();
  
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadTestByCourseName(int courseId, String courseName) async {
    tests = await DBProvider.db.getTestsByCourse(courseId);
    _currentCourseName = courseName;
    notifyListeners();
  }

  bool checkCourse(String courseName) {
    return (courses.indexWhere((course) => course.name == courseName) != -1) ? true : false;
  }

  Future<void> addCourse(Course newCourse) async {
    int id = await DBProvider.db.createCourse(newCourse);
    newCourse.id = id;

    courses.add(newCourse);
    notifyListeners();
  }

  Future<void> updateNameCourse(String oldName, String newName) async {
    await DBProvider.db.updateNameCourse(oldName, newName);
    courses = [...courses.map((course) {
      if(course.name != oldName) return course;
      return  Course(id: course.id, name: newName);
    })];
    
    notifyListeners();
  }

  Future<void> deleteCourse(int courseId) async {
    await DBProvider.db.deleteCourse(courseId);
    courses = [
      ...courses.where((course) => course.id != courseId)
    ];
    notifyListeners();
  }

  bool checkTestByName(String testName) {
    return (tests.indexWhere((test) => test.name == testName) != -1) ? true : false;
  }

  Future<void> addTest(int courseId, Test newTest) async {
    int id = await DBProvider.db.createTest(newTest, courseId);

    newTest.id = id;
    tests = [...tests, newTest];
    notifyListeners();
  }

  Future<void> updateTest(Test newTest) async {
    await DBProvider.db.updateTest(newTest);
    tests = [
      ...tests.map((test) {
        if (test.id != newTest.id) return test;

        return newTest;
      })
    ];
    notifyListeners();
  }

  Future<void> deleteTest(int id) async {
    await DBProvider.db.deleteTest(id);
    tests = [
      ...tests.where((test) => test.id != id)
    ];
    notifyListeners();
  }
}
