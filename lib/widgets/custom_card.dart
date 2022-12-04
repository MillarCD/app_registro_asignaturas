import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:asignaturas/models/course.dart';
import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';
import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/widgets/test_tile.dart';
import 'package:asignaturas/widgets/dismissible_background.dart';

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

    return Dismissible(
      key: UniqueKey(),
      background: const DismissibleBackGround(alignment: Alignment.centerLeft,),
      secondaryBackground: const DismissibleBackGround(alignment: Alignment.centerRight),
      onDismissed: (direction) {
        print('[CUSTOM CARD]: delete course');
        coursesProvider.deleteCourse(course.name);
      },
      child: Card(
        color: Colors.amber,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
           
              _CourseNameTile(course: course, coursesProvider: coursesProvider),
    
              if (coursesProvider.currentCourseName==course.name) ...tests.map((test) {
                return Column(
                  children: [
                    const SizedBox(height: 10,),
                    TestTile(test:test),
                  ],
                );
              }),
    
              if (coursesProvider.currentCourseName==course.name) const SizedBox(height: 10,),
      
              if (coursesProvider.currentCourseName==course.name) MaterialButton(
                color: Colors.greenAccent,
                height: 50,
                minWidth: double.infinity,
                child: const Text("Agregar Evaluación", style: TextStyle(fontSize: 20),),
                onPressed: () {
                  // TODO: mostrar modal para crear evaluacion
                  print("[CUSTOM_CARD]: agregar evaluacion");
                  final formProvider = Provider.of<FormProvider>(context, listen: false);
                  formProvider.operation = 'add';
                  formProvider.entity = 'test';
                  formProvider.forms['courseName'] = course.name;
                  Provider.of<ModalProvider>(context, listen: false).isVisible = true;
                },
              )
      
      
            ],
          ),
        ),
      ),
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
            onPressed: () {
              print("[CUSTOM CARD]: IconButton pressed");
              final formProvider = Provider.of<FormProvider>(context, listen: false);
              formProvider.operation = 'edit';
              formProvider.entity = 'course';
              formProvider.forms = {'oldName': course.name};
              Provider.of<ModalProvider>(context, listen: false).isVisible = true;
            },
            icon: const Icon(Icons.edit))
          )
      ],
    );
  }
}