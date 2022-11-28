import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/widgets/course_form.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:asignaturas/widgets/custom_card.dart';
import 'package:asignaturas/widgets/modal.dart';
import 'package:asignaturas/providers/modal_provider.dart';
import 'package:asignaturas/providers/courses_provider.dart';

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
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverAppBar(
                title: Text("Asignaturas"),
              ),
            
              if (courses.isEmpty) const SliverToBoxAdapter(
                child: Text('Lista vacia.'),
              )
              else SliverList(
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
          ),

          if (modalProvider.isVisible) const Modal(
            child: CourseForm(),
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
          Provider.of<FormProvider>(context, listen: false).operation = 'add';
          print('[COURSES SCREEN] add course');
          modalProvider.isVisible = true;
        },
      ) : null,

    );
  }
}