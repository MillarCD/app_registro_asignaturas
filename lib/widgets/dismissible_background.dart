import 'package:flutter/material.dart';

class DismissibleBackGround extends StatelessWidget {
  const DismissibleBackGround({super.key, required this.alignment});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.orange[700],
      child: const Icon(Icons.delete),
     
    );
  }
}