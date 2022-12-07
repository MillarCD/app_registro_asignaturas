import 'package:asignaturas/widgets/test_form.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';
import 'package:asignaturas/widgets/course_form.dart';
import 'package:asignaturas/widgets/custom_card.dart';
import 'package:asignaturas/widgets/modal.dart';

class CoursesScreen extends StatelessWidget {

  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final coursesProvider = Provider.of<CoursesProvider>(context);
    final modalProvider = Provider.of<ModalProvider>(context);

    final courses = coursesProvider.courses;

    return Scaffold(
      body: Stack(
        children: [
          if (courses.isNotEmpty) CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverAppBar(
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Asignaturas'),
                  centerTitle: true,
                  background: _FlexibleBackground(),
                ),
              ),
            
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: courses.length,
                  (context, index) {
                    return CustomCard(
                      course: courses[index],
                    );
                  }
                ),
              ),
            ],
          ) else const NoCourseWidget(),
       

          if (modalProvider.isVisible) Modal(
            child: (Provider.of<FormProvider>(context, listen: false).entity == 'course')
              ? const CourseForm()
              : const TestForm(),
          ),

        ]
      ),

      floatingActionButton: (!modalProvider.isVisible) ? FloatingActionButton(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Icons.add)
        ),
        onPressed: () {
          final formProvider = Provider.of<FormProvider>(context, listen: false);
          formProvider.operation = 'add';
          formProvider.entity = 'course';
          print('[COURSES SCREEN] add course');
          modalProvider.isVisible = true;
        },
      ) : null,

    );
  }
}

class NoCourseWidget extends StatelessWidget {
  const NoCourseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon( Icons.library_books_outlined, size: 100),
          Text("No hay ninguna asignatura aún", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
        ],
      ),
    );
  }
}

class _FlexibleBackground extends StatelessWidget {
  const _FlexibleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
