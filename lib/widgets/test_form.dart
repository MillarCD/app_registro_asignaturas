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

    print('[TEST FORM] hello I\'m the build method');

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
            },
          ),
          const SizedBox(height: 10,),

          DateSelect(
            title: transformDate(showDatePickedProvider.datePicked) ?? 'Agregar Fecha',
            onPressed: () async {
              print('[TEST FORM]: mostrar calendario');
              final DateTime now = DateTime.now();
              showDatePickedProvider.datePicked = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(now.year), 
                lastDate: DateTime(now.year, 12, 31),
              );
              print("Date: ${showDatePickedProvider.datePicked}");
              
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
            },
          ),

          BottomButtons(
            formProvider: formProvider,
            modalProvider: modalProvider,
            failFunction: () => showDatePickedProvider.datePicked = null,
            successFunction: () async {
              print('[TEST FORM] operation: ${formProvider.operation}');
              print('[TEST FORM]: object: ${formProvider.forms}');

              if (formProvider.operation == 'add') {
                print('[TEST FORM] guardar evaluacion');
                await coursesProvider.addTest(
                  formProvider.forms['courseName'],
                  Test.fromMap(formProvider.forms)
                );
              } else {
                print('[TEST FORM] editar evaluacion');
                // TODO: una vez añadida la base de datos
              }

              showDatePickedProvider.datePicked = null;
            }
          )
        ],
      )
    );
  }
}