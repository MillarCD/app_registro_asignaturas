import 'package:asignaturas/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asignaturas/providers/courses_provider.dart';

class CoursesScreen extends StatelessWidget {

  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final coursesProvider = Provider.of<CoursesProvider>(context);
    final courses = coursesProvider.courses;

    return Scaffold(
      body: CustomScrollView(
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
          )
        ],
    
      ),
    );
  }
}