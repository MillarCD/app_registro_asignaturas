import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/models/course.dart';

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
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          MaterialButton(
            color: Colors.red.withOpacity(0.8),
            minWidth: double.infinity,
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
            },
          ),

          if (coursesProvider.currentCourseName==course.name) ...tests.map((test) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.blue,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: const [
                      Text("nombre prueba"),
                      Text("fecha prueba")
                    ],
                  ),

                  const Text("70"),
                ],
              )
            );
          }),
    
          
    
    
        ],
      ),
    );
  }
}