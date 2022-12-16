import 'package:asignaturas/providers/show_date_picked_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asignaturas/models/test.dart';
import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';
import 'package:asignaturas/utils/utils.dart';
import 'package:asignaturas/widgets/dismissible_background.dart';

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
        Provider.of<CoursesProvider>(context, listen: false).deleteTest(test.id!);
      },

      child: ListTile(
        title: Text(test.name, style: const TextStyle(fontSize: 20)),
        subtitle: Text(date, style: const TextStyle(fontSize: 20)),
        trailing: test.calification!=null ? Text(test.calification.toString().substring(0,3), style: const TextStyle(fontSize: 20)) : null,
        tileColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),

        onTap: () {
          print("[TEST TILE]: editar evaluacion");
          final formProvider = Provider.of<FormProvider>(context, listen: false);
          Provider.of<ShowDatePickedProvider>(context, listen: false).datePicked = test.date;

          formProvider.operation = 'edit';
          formProvider.entity = 'test';
          formProvider.forms = test.toMap();

          Provider.of<ModalProvider>(context, listen: false).isVisible = true;
        },
      )
    );
  }
}