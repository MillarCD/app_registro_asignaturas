import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:asignaturas/widgets/custom_card.dart';
import 'package:asignaturas/widgets/modal_form.dart';
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

          if (modalProvider.isVisible) const ModalForm(),

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
          print('[COURSES SCREEN] add course');
          // TODO: desplegar ventana para crear asignatura
          modalProvider.isVisible = true;
        },
      ) : null,

    );
  }
}