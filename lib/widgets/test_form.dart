import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';
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
    
    formProvider.formKey = GlobalKey<FormState>();

    DateTime? datePicked;

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
            validator: (value) {
              if (value=='' || value==null) return 'Campo obligatorio';
              if (coursesProvider.checkTestByName(value)) return 'El nombre ya existe';

              formProvider.forms['name'] = value;
            },
          ),
          const SizedBox(height: 10,),

          DateSelect(
            title: 'Agregar Fecha',
            onPressed: () async {
              print('[TEST FORM]: mostrar calendario');
              final DateTime now = DateTime.now();
              datePicked = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(now.year), 
                lastDate: DateTime(now.year, 12, 31),
              );
              print("Date: $datePicked");
              
              formProvider.forms['date'] = datePicked;
            },
          ),
          
          const SizedBox(height: 10,),

          CustomTextField(
            labelText: 'Nota',
            inputType: TextInputType.number,
            validator: (value) {
              if (value == '' || value==null) return null;
              final double nota = double.tryParse(value) ?? -1;
              if (nota < 1 || nota>7) return "La nota debe ser mayor a 1 y menor a 7";

              formProvider.forms['calification'] = value;
            },
          ),

          BottomButtons(
            formProvider: formProvider,
            modalProvider: modalProvider,
            successFunction: () async {

            }
          )
        ],
      )
    );
  }
}



