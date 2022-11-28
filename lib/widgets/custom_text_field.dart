
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asignaturas/providers/courses_provider.dart';

class CustomTextField extends StatelessWidget {

  final String labelText;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return TextFormField(
      decoration: InputDecoration(
        border: const  OutlineInputBorder(),
        labelText: labelText,
      ),
      validator: validator
    );
  }
}