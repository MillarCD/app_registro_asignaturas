import 'package:asignaturas/models/course.dart';
import 'package:asignaturas/widgets/bottom_button.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:asignaturas/providers/courses_provider.dart';
import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';
import 'package:asignaturas/widgets/custom_text_field.dart';

class CourseForm extends StatelessWidget {
  const CourseForm({super.key});

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final formProvider = Provider.of<FormProvider>(context);
    final modalProvider = Provider.of<ModalProvider>(context);
    
    formProvider.formKey = GlobalKey<FormState>();


    return Form(
        key: formProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            const Text('Agregar Asignatura', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10,),
      
            CustomTextField(
              labelText: 'Nombre Asignatura',
              validator: (value) {
                if (value == '' || value == null) return 'Campo obligatorio';            
                if (coursesProvider.checkCourse(value)) return 'La asignatura ya esta registrada';

                formProvider.forms['name'] = value;
              },
            ),
      
            BottomButtons(
              formProvider: formProvider,
              modalProvider: modalProvider,
              successFunction: () async {
                print('[COURSE FORM]: action: ${formProvider.operation}');
                if (formProvider.operation == 'add') {
                  print('[COURSE FORM] guardar...');
                  await coursesProvider.addCourse(Course.fromMap(formProvider.forms));
                } else {
                  print('[COURSE FORM]: editar asignatura');
                  await coursesProvider.updateNameCourse(formProvider.forms['oldName'], formProvider.forms['name']);
                }
              },
            )
          ],
        ),
      );
    
    
  }
}