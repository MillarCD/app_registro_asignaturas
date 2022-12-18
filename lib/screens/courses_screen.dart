import 'package:asignaturas/providers/theme_provider.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    final courses = coursesProvider.courses;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          if (courses.isNotEmpty) CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Asignaturas', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                  centerTitle: true,
                  background: const _FlexibleBackground(),
                ),
                actions: [
                  IconButton(
                    icon: Icon((themeProvider.themeSelected == 'light')
                      ? Icons.light_mode_outlined
                      : Icons.mode_night_outlined
                    ),
                    onPressed: () {
                      if (themeProvider.themeSelected == 'light') {
                        themeProvider.themeSelected = 'dark';
                        return;
                      }
                      themeProvider.themeSelected = 'light';
                    },
                  ),
                ],
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
          ) 
          else NoCourseContainer(
            children: (coursesProvider.isLoading) ? [
                CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,)
              ] : [
                Icon( Icons.library_books_outlined, size: 100, color: Colors.black.withOpacity(0.5)),
                const Text("Crea una asignatura", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ],
          ),
       
          if (modalProvider.isVisible) Modal(
            child: (Provider.of<FormProvider>(context, listen: false).entity == 'course')
              ? const CourseForm()
              : const TestForm(),
          ),

        ]
      ),

      floatingActionButton: (!modalProvider.isVisible) ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final formProvider = Provider.of<FormProvider>(context, listen: false);
          formProvider.operation = 'add';
          formProvider.entity = 'course';
          modalProvider.isVisible = true;
        },
      ) : null,

    );
  }
}

class NoCourseContainer extends StatelessWidget {
  const NoCourseContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class _FlexibleBackground extends StatelessWidget {
  const _FlexibleBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}
