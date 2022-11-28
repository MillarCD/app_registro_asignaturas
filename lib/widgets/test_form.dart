import 'package:asignaturas/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class TestForm extends StatelessWidget {
  const TestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: const [
          CustomTextField(
            labelText: 'Nombre Evaluacion',
          ),


        ],
      )
    );
  }
}

