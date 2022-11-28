import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseForm extends StatelessWidget {
  const CourseForm({super.key});

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);

    return Column(
      children: [
        CustomTextField(
          labelText: 'Nombre Asignatura',
          validator: (value) {
            // TODO: comprobar que el valor no este en la base de datos
            if (value == '' || value == null) return 'Campo obligatorio';
            
            if (coursesProvider.checkCourse(value)) return 'La asignatura ya esta registrada';
          },
        )
      ],
    );
  }
}