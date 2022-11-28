
import 'package:flutter/cupertino.dart';

class FormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, dynamic> forms = {};
  bool _isLoading = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  } 
  bool get isLoading => _isLoading;



  bool isValidForm() {

    print(formKey.currentState?.validate());
    print('objects: $forms');

    return formKey.currentState?.validate() ?? false;
  }
}