import 'package:asignaturas/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CourseForm extends StatelessWidget {
  const CourseForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomTextField(
          labelText: 'Nombre Asignatura',
        )
      ],
    );
  }
}