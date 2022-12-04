import 'package:flutter/material.dart';

import 'package:asignaturas/widgets/dismissible_background.dart';
import 'package:asignaturas/models/test.dart';
import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/utils/utils.dart';
import 'package:provider/provider.dart';

class TestTile extends StatelessWidget {
  final Test test;
  const TestTile({
    Key? key,
    required this.test,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String date = test.date!=null ? transformDate(test.date)! : "";
    return Dismissible(
      key: UniqueKey(),
      background: const DismissibleBackGround(alignment: Alignment.centerLeft,),
      secondaryBackground: const DismissibleBackGround(alignment: Alignment.centerRight),
      onDismissed: (direction) {
        print("[CUSTOM CARD]: se borra la evaluacion");
        print('[CUSTOM CARD] direction: $direction');
        Provider.of<CoursesProvider>(context, listen: false).deleteTest(test.id!);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.blue,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(test.name, style: const TextStyle(fontSize: 20)),
                  Text(date, style: const TextStyle(fontSize: 20))
                ],
              ),
            ),
            if (test.calification != null)
              Expanded(flex: 1, child: Text(test.calification.toString().substring(0,3), style: const TextStyle(fontSize: 20)))
          ],
        )
      ),
    );
  }
}