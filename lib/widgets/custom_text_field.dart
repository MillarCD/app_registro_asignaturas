
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String labelText;

  const CustomTextField({
    Key? key,
    required this.labelText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const  OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}