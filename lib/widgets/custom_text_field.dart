
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final String? initialValue;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.validator,
    this.inputType,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondaryContainer),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondaryContainer
          )
        )
      ),
      validator: validator,
      keyboardType: inputType,
      initialValue: initialValue,
    );
  }
}