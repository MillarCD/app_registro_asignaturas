import 'package:asignaturas/models/course.dart';
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
      
            _BottomButtons(formProvider: formProvider, modalProvider: modalProvider)
          ],
        ),
      );
    
    
  }
}

class _BottomButtons extends StatelessWidget {
  const _BottomButtons({
    Key? key,
    required this.formProvider,
    required this.modalProvider,
  }) : super(key: key);

  final FormProvider formProvider;
  final ModalProvider modalProvider;

  @override
  Widget build(BuildContext context) {

    final coursesProvider = Provider.of<CoursesProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: (formProvider.isLoading) ? null : () {
            print('[MODAL FORM] cancelar');
            modalProvider.isVisible = false;
            formProvider.forms.clear();
          },
          child: const Text('Cancelar', style: TextStyle(fontSize: 15)),
        ),
        TextButton(
          onPressed: (formProvider.isLoading) ? null : () {
            formProvider.isLoading = true;
            if (!formProvider.isValidForm()) {
              print("[MODAL FORM] formulario invalido");
              formProvider.isLoading = false;
              return;
            };

            print('[MODAL FORM] guardar...');
            
            coursesProvider.addCourse(Course.fromMap(formProvider.forms));
            formProvider.isLoading = false;
            formProvider.forms.clear();
            modalProvider.isVisible = false;
          },
          child: const Text('Guardar', style: TextStyle(fontSize: 15)),
        ),
      ],
    );
  }
}