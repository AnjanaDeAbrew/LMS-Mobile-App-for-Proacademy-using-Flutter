import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/controllers/auth_controller.dart';
import 'package:proacademy_lms/utils/alert_helper.dart';

class SignupProvider extends ChangeNotifier {
  //---first name controller
  final _firstName = TextEditingController();
  //--- get first name controller
  TextEditingController get firstNameController => _firstName;

  //---last name controller
  final _lastName = TextEditingController();
  //--- get last name controller
  TextEditingController get lastNameController => _lastName;

  //---email controler
  final _email = TextEditingController();
  //--- get email controller
  TextEditingController get emailController => _email;

  //----password controller
  final _password = TextEditingController();
  //--- get password controller
  TextEditingController get passwordController => _password;

  //----birthday controller
  final _birthday = TextEditingController();
  //--- get birthday controller
  TextEditingController get birthdayController => _birthday;

  //age controller
  int _age = 0;

  int get age => _age;

  void setAge(String formattedDate) {
    _age = DateTime.now().year - int.parse(formattedDate.substring(0, 4));
    notifyListeners();
  }

  //----mobile controller
  final _mobileController = TextEditingController();
  //--- get password controller
  TextEditingController get mobileController => _mobileController;

  //----mobile controller
  String _mobileNumber = '';
  String get mobileNumber => _mobileNumber;
  set setMobile(String value) {
    _mobileNumber = value;
    notifyListeners();
  }

  //----gender controller
  String _gender = 'male';
  //--- get gender controller
  String get genderController => _gender;
  //set gender controller
  void setGender(String value) {
    _gender = value;

    notifyListeners();
  }

  //----address controller
  final _address = TextEditingController();
  //--- get address controller
  TextEditingController get addressController => _address;

  //----school controller
  final _school = TextEditingController();
  //--- get password controller
  TextEditingController get schoolController => _school;

  //----loading state
  bool _isLoading = false;

  //get loader state
  bool get isLoading => _isLoading;

  //-----set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //----------signup fuction
  Future<void> startSignup(BuildContext context) async {
    try {
      if (_firstName.text.isNotEmpty &&
          _lastName.text.isNotEmpty &&
          _email.text.isNotEmpty &&
          _password.text.isNotEmpty &&
          _birthday.text.isNotEmpty &&
          _mobileNumber.isNotEmpty &&
          _gender.isNotEmpty &&
          _address.text.isNotEmpty &&
          _school.text.isNotEmpty) {
        //---start the loader
        setLoader = true;

        //----start creating the user account
        await AuthController()
            .signupUser(
                _email.text,
                _password.text,
                _firstName.text,
                _lastName.text,
                _birthday.text,
                _age,
                _mobileNumber,
                _gender,
                _address.text,
                _school.text,
                context)
            .then((value) {
          _email.clear();
          _password.clear();
          _firstName.clear();
          _lastName.clear();
          _birthday.clear();
          _mobileController.clear();
          _address.clear();
          _school.clear();
        });

        //----stop the loader
        setLoader = false;
      } else {
        //-----shows a error dialog
        AlertHelper.showAlert(context, "Validation error",
            "Fill all the fields", DialogType.ERROR);
      }
    } catch (e) {
      Logger().e(e);
      //----stop the loader
      setLoader = false;
    }
  }
}
