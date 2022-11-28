
import 'package:flutter/cupertino.dart';

class FormProvider extends ChangeNotifier {

  GlobalKey<FormState>? formKey;
  Map<String, dynamic> forms = {};
  bool _isLoading = false;
  String operation = 'add'; // add || edit
  
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  } 
  bool get isLoading => _isLoading;



  bool isValidForm() {
    if (formKey == null) return false;
    
    print(formKey!.currentState?.validate());
    print('objects: $forms');

    return formKey!.currentState?.validate() ?? false;
  }
}