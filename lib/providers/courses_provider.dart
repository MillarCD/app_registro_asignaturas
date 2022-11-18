import 'package:flutter/material.dart';

import 'package:asignaturas/models/test.dart';
import 'package:asignaturas/models/course.dart';

class CoursesProvider extends ChangeNotifier {
  List<Course> courses = [];
  List<Test> tests = [];

  String currentCourseName = "";

  CoursesProvider() {
    loadCourses();
    print("[COURSES_PROVIDER]: se cargaron los cursos");
  }

  Future<void> loadCourses() async {
    // Carga los cursos de la base de datos y los recopila en courses
    courses = [
      Course(name: 'Evaluacion de proyectos informaticos'),
      Course(name: 'simulacion'),
      Course(name: 'taller de ingenieria de software')
    ];

  
    notifyListeners();
  }

  Future<void> loadTestByCourseName(String courseName) async {
    print("[COURSES_PROVIDER]: cargar tests: $courseName");
    tests = [
        Test(
          name: "PP1",
          calification: 7,
          date: DateTime(2022, 11, 15)
        ),
        Test(
          name: "Trabajo 2",
          date: DateTime(2022, 11, 15)
        ),
        Test(
          name: "Exposicion Simulaciones",
          calification: 5.9,
        ),
    ];
    currentCourseName = courseName;
    notifyListeners();
  }
}
