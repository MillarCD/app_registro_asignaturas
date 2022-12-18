import 'package:flutter/material.dart';

import 'package:asignaturas/providers/form_provider.dart';
import 'package:asignaturas/providers/modal_provider.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key? key,
    required this.formProvider,
    required this.modalProvider,
    required this.successFunction,
    this.failFunction,
  }) : super(key: key);

  final FormProvider formProvider;
  final ModalProvider modalProvider;
  final Future<void> Function() successFunction;
  final void Function()? failFunction;
  

  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: (formProvider.isLoading) ? null : () {
            modalProvider.isVisible = false;
            FocusScope.of(context).unfocus();
            if (failFunction != null) failFunction!();
            formProvider.forms.clear();
          },
          child: Text('Cancelar', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary)),
        ),
        TextButton(
          onPressed: (formProvider.isLoading) ? null : () async {
            formProvider.isLoading = true;
            FocusScope.of(context).unfocus();
            if (!formProvider.isValidForm()) {
              formProvider.isLoading = false;
              return;
            }

            await successFunction();

            formProvider.forms.clear();
            formProvider.isLoading = false;
            modalProvider.isVisible = false;

          },
          child: Text('Guardar', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary)),
        ),
      ],
    );
  }
}