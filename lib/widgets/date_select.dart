import 'package:flutter/material.dart';

class DateSelect extends StatefulWidget {
  const DateSelect({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;

  @override
  State<DateSelect> createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  @override
  Widget build(BuildContext context) {

    print('[DATE DELECT] title: ${widget.title}');

    return SizedBox(
      height: 50,
      width: double.infinity,
      child: MaterialButton(
        color: Colors.grey[300],
        onPressed: widget.onPressed, 
        child: Text(widget.title, style: const TextStyle(fontSize: 16),),
      )
    );
  }
}