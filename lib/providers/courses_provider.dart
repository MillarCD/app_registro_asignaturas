import 'package:flutter/material.dart';

import 'package:asignaturas/models/test.dart';
import 'package:asignaturas/models/course.dart';

class CoursesProvider extends ChangeNotifier {
  List<Course> courses = [];
  List<Test> tests = [];

  String _currentCourseName = "";
  set currentCourseName(String courseName) {
    _currentCourseName = courseName;
    notifyListeners();
  }
  String get currentCourseName => _currentCourseName;

  CoursesProvider() {
    loadCourses();
    print("[COURSES_PROVIDER]: se cargaron los cursos");
  }

  Future<void> loadCourses() async {
    // Carga los cursos de la base de datos y los recopila en courses
    courses = [
      Course(id: 1, name: 'Evaluacion de proyectos informaticos'),
      Course(id: 2, name: 'simulacion'),
      Course(id: 3, name: 'taller de ingenieria de software')
    ];

  
    notifyListeners();
  }

  Future<void> loadTestByCourseName(String courseName) async {
    print("[COURSES_PROVIDER]: cargar tests: $courseName");
    tests = [
        Test(
          id: 1,
          name: "PP1",
          calification: 7,
          date: DateTime(2022, 11, 15)
        ),
        Test(
          id: 2,
          name: "Trabajo 2",
          date: DateTime(2022, 11, 15)
        ),
        Test(
          id: 3,
          name: "Exposicion Simulaciones",
          calification: 5.9993,
        ),
    ];
    _currentCourseName = courseName;
    notifyListeners();
  }

  bool checkCourse(String courseName) {
    return (courses.indexWhere((course) => course.name == courseName) != -1) ? true : false;
  }

  Future<void> addCourse(Course newCourse) async {
    // TODO: add course to database;

    // TODO: añadir la id que retorna la consulta sql
    courses.add(newCourse);
    notifyListeners();
  }

  Future<void> updateNameCourse(String oldName, String newName) async {
    // TODO: update database
    courses = [...courses.map((course) {
      if(course.name != oldName) return course;
      return  Course(id: course.id, name: newName);
    })];
    
    notifyListeners();
  }

  Future<void> deleteCourse(String courseName) async {
    // TODO: borrar asignatura de la base de datos
    courses = [
      ...courses.where((course) => course.name != courseName)
    ];
    notifyListeners();
  }

  bool checkTestByName(String testName) {
    return (tests.indexWhere((test) => test.name == testName) != -1) ? true : false;
  }

  Future<void> addTest(String courseName, Test newTest) async {
    // TODO: add test to database

    // TODO: añadir la id que retorna la consulta sql
    tests = [...tests, newTest];
    notifyListeners();
  }

  Future<void> updateTest(Test newTest) async {
    // TODO: update database
  }

  Future<void> deleteTest(int id) async {
    // TODO: borrar evaluacion de la base de datos
    tests = [
      ...tests.where((test) => test.id != id)
    ];
    notifyListeners();
  }
}
