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
        coursesProvider.deleteCourse(course.id!);
      },
      child: Card(
        color: Theme.of(context).colorScheme.primary,
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
                color: Theme.of(context).colorScheme.secondary,
                height: 50,
                minWidth: double.infinity,
                child: const Text("Agregar Evaluación", style: TextStyle(fontSize: 20),),
                onPressed: () {
                  final formProvider = Provider.of<FormProvider>(context, listen: false);
                  formProvider.operation = 'add';
                  formProvider.entity = 'test';
                  formProvider.forms['courseId'] = course.id;
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
            height: 70,
            child: Text(
              course.name,
              style: const TextStyle(fontSize: 20,),
              overflow: TextOverflow.ellipsis,
            ),
            onPressed: () {
              if(coursesProvider.currentCourseName!=course.name) {
                coursesProvider.loadTestByCourseName(course.id!, course.name);
                return;
              }
              coursesProvider.currentCourseName = "";
            },
          ),
        ),
        if(coursesProvider.currentCourseName==course.name) Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              final formProvider = Provider.of<FormProvider>(context, listen: false);
              formProvider.operation = 'edit';
              formProvider.entity = 'course';
              formProvider.forms = {'oldName': course.name};
              Provider.of<ModalProvider>(context, listen: false).isVisible = true;
            },
            icon: const Icon(Icons.edit)),
        )
      ],
    );
  }
}