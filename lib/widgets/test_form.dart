import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asignaturas/models/test.dart';
import 'package:asignaturas/providers/show_date_picked_provider.dart';
import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';
import 'package:asignaturas/utils/utils.dart';
import 'package:asignaturas/widgets/bottom_button.dart';
import 'package:asignaturas/widgets/custom_text_field.dart';
import 'package:asignaturas/widgets/date_select.dart';


class TestForm extends StatelessWidget {
  const TestForm({super.key});

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final formProvider = Provider.of<FormProvider>(context);
    final modalProvider = Provider.of<ModalProvider>(context);
    final showDatePickedProvider = Provider.of<ShowDatePickedProvider>(context);
    
    formProvider.formKey = GlobalKey<FormState>();

    return Form(
      key: formProvider.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Agregar Evaluación', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10,),
          
          CustomTextField(
            labelText: 'Nombre Evaluacion',
            initialValue: formProvider.forms['name'],
            validator: (value) {
              if (value=='' || value==null) return 'Campo obligatorio';
              if (coursesProvider.checkTestByName(value)) return 'El nombre ya existe';

              formProvider.forms['name'] = value;
              return null;
            },
          ),
          const SizedBox(height: 10,),

          DateSelect(
            title: transformDate(showDatePickedProvider.datePicked) ?? 'Agregar Fecha',
            onPressed: () async {
              final DateTime now = DateTime.now();
              showDatePickedProvider.datePicked = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(now.year), 
                lastDate: DateTime(now.year, 12, 31),
                builder: (context, child) {

                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: Theme.of(context).colorScheme.onSecondary
                      ),
                    ),
                    child: child!
                  );
                },
              );
              
              formProvider.forms['date'] = showDatePickedProvider.datePicked;
            },
          ),
          
          const SizedBox(height: 10,),

          CustomTextField(
            labelText: 'Nota',
            initialValue: (formProvider.forms['calification'] != null)
              ? formProvider.forms['calification'].toString()
              : null,
            inputType: TextInputType.number,
            validator: (value) {
              if (value == '' || value==null) return null;
              final double nota = double.tryParse(value) ?? -1;
              if (nota < 1 || nota>7) return "La nota debe ser mayor a 1 y menor a 7";

              formProvider.forms['calification'] = nota;
              return null;
            },
          ),

          BottomButtons(
            formProvider: formProvider,
            modalProvider: modalProvider,
            failFunction: () => showDatePickedProvider.datePicked = null,
            successFunction: () async {

              if (formProvider.operation == 'add') {
                await coursesProvider.addTest(
                  formProvider.forms['courseId'],
                  Test.fromMap(formProvider.forms)
                );
              } else {
                await coursesProvider.updateTest(Test.fromMap(formProvider.forms));
              }

              showDatePickedProvider.datePicked = null;
            }
          )
        ],
      )
    );
  }
}