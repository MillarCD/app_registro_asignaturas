import 'package:asignaturas/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:asignaturas/models/test.dart';
import 'package:asignaturas/models/course.dart';
import 'package:asignaturas/providers/courses_provider.dart';

class CustomCard extends StatelessWidget {

  final Course course;

  const CustomCard({
    super.key,
    required this.course
  });

  @override
  Widget build(BuildContext context) {

    final coursesProvider = Provider.of<CoursesProvider>(context);
    final tests = coursesProvider.tests;

    return Card(
      color: Colors.amber,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
         
            _CourseNameTile(course: course, coursesProvider: coursesProvider),

            if (coursesProvider.currentCourseName==course.name) ...tests.map((test) {
              return _TestTile(test:test);
            }),

            if (coursesProvider.currentCourseName==course.name) const SizedBox(height: 10,),
    
            if (coursesProvider.currentCourseName==course.name) MaterialButton(
              color: Colors.greenAccent,
              height: 50,
              minWidth: double.infinity,
              child: const Text("Agregar Evaluación", style: TextStyle(fontSize: 20),),
              onPressed: () {
                // TODO: desplegar panel para agregar asignaturas
                print("[CUSTOM_CARD]: agregar evaluacion");
              },
            )
    
    
          ],
        ),
      ),
    );
  }
}

class _TestTile extends StatelessWidget {
  final Test test;
  const _TestTile({
    Key? key,
    required this.test,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String date = test.date!=null ? transformDate(test.date!) : "";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 10),
      color: Colors.blue,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(test.name, style: const TextStyle(fontSize: 20)),
                Text(date, style: const TextStyle(fontSize: 20))
              ],
            ),
          ),
          if (test.calification != null)
            Expanded(flex: 1, child: Text(test.calification.toString().substring(0,3), style: const TextStyle(fontSize: 20)))
        ],
      )
    );
  }
}

class _CourseNameTile extends StatelessWidget {
  const _CourseNameTile({
    Key? key,
    required this.course,
    required this.coursesProvider,
  }) : super(key: key);

  final Course course;
  final CoursesProvider coursesProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: MaterialButton(
            color: Colors.red.withOpacity(0.8),
            height: 70,
            child: Text(
              course.name,
              style: const TextStyle(fontSize: 20,),
              overflow: TextOverflow.ellipsis,
            ),
            onPressed: () {
              print("toggle para mostrar/ocultar los test");
              if(coursesProvider.currentCourseName!=course.name) {
                coursesProvider.loadTestByCourseName(course.name);
                return;
              }
              coursesProvider.currentCourseName = "";
            },
          ),
        ),
        if(coursesProvider.currentCourseName==course.name) Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () => print("IconButton pressed"),
            icon: const Icon(Icons.edit))
          )
      ],
    );
  }
}