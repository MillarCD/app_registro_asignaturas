import 'package:flutter/material.dart';

import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key? key,
    required this.formProvider,
    required this.modalProvider,
    required this.successFunction,
  }) : super(key: key);

  final FormProvider formProvider;
  final ModalProvider modalProvider;
  final Future<void> Function() successFunction;
  

  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: (formProvider.isLoading) ? null : () {
            print('[BOTTOM BUTTON] cancelar');
            modalProvider.isVisible = false;
            formProvider.forms.clear();
          },
          child: const Text('Cancelar', style: TextStyle(fontSize: 15)),
        ),
        TextButton(
          onPressed: (formProvider.isLoading) ? null : () async {
            formProvider.isLoading = true;
            if (!formProvider.isValidForm()) {
              print("[BOTTOM BUTTON] formulario invalido");
              formProvider.isLoading = false;
              return;
            };

            await successFunction();

            formProvider.forms.clear();
            formProvider.isLoading = false;
            modalProvider.isVisible = false;
          },
          child: const Text('Guardar', style: TextStyle(fontSize: 15)),
        ),
      ],
    );
  }
}