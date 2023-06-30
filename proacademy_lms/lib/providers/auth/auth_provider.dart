import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/controllers/auth_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/course/course_provider.dart';
import 'package:proacademy_lms/screens/auth/login_page.dart';
import 'package:proacademy_lms/screens/main/main_screen.dart';
import 'package:proacademy_lms/utils/alert_helper.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final AuthController _authController = AuthController();

  //------initialize the user and listen to the auth state
  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        //------------If the user objecct is null ---- that means the user is signed out or not exists
        //------------so send to the signup
        Logger().i("User is currently signed out!");

        UtilFunctions.navigateTo(context, const LoginPage());
      } else {
        //------------If the user objecct is not null ---- that means the auth state is logged in
        //------------so redirect the user to home
        Logger().i("User is signed in!");

        await startFetchUserData(user.uid, context).then((value) {
          Provider.of<CourseProvider>(context, listen: false)
              .startFetchProducts();

          // Provider.of<EnrollProvider>(context, listen: false)
          //     .startFetchProducts(studentModel!.sid);
          UtilFunctions.navigateTo(context, const MainScreen());
        });
      }
    });
  }

//------------start fetching user data
//--------store fetched user model
//----so that any ui can access this user model as want
  StudentModel? _studentModel;

  StudentModel? get studentModel => _studentModel;

  Future<void> startFetchUserData(String sid, BuildContext context) async {
    try {
      await _authController.fetchUserData(sid).then((value) {
        //----check if fetched result is not null
        if (value != null) {
          _studentModel = value;
          notifyListeners();
        } else {
          //--show an error
          AlertHelper.showAlert(context, "Error",
              "Error while fetching user data", DialogType.ERROR);
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //===============================upload and update user image

//------product image object
  File _image = File("");

  //----get picked file
  File get image => _image;
  //----loading state
  bool _isLoading = false;

  //get loader state
  bool get isLoading => _isLoading;

  //-----set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

//---------------method to upload and update image from gallery
  Future<void> selectAndUploadProfileImageCamera(BuildContext context) async {
    try {
      _image = (await UtilFunctions.pickImageFromCamera())!;

      if (_image.path != "") {
        //----start the loader
        setLoader = true;
        // ignore: use_build_context_synchronously
        String imgUrl = await _authController.uploadAndUpdatePickedImage(
            _image, _studentModel!.sid, context);
        if (imgUrl != "") {
          _studentModel!.img = imgUrl;

          notifyListeners();

          //----stop the loader
          setLoader = false;
        }
        //----stop the loader
        setLoader = false;
      }
    } catch (e) {
      Logger().e(e);
      //----stop the loader
      setLoader = false;
    }
  }

  //---------------method to upload and update image from gallery
  Future<void> selectAndUploadProfileImageGallery(BuildContext context) async {
    try {
      _image = (await UtilFunctions.pickImageFromGallery())!;

      if (_image.path != "") {
        //----start the loader
        setLoader = true;
        // ignore: use_build_context_synchronously
        String imgUrl = await _authController.uploadAndUpdatePickedImage(
            _image, _studentModel!.sid, context);
        if (imgUrl != "") {
          _studentModel!.img = imgUrl;
          notifyListeners();

          //----stop the loader
          setLoader = false;
        }
        //----stop the loader
        setLoader = false;
      }
    } catch (e) {
      Logger().e(e);
      //----stop the loader
      setLoader = false;
    }
  }

  //-update the current user online state and last seen
  void updateOnlineStates(bool val, BuildContext context) {
    try {
      _authController.updateOnlineStates(_studentModel!.sid, val, context);
    } catch (e) {
      Logger().e(e);
    }
  }

  void setDeviceToken(String token) {
    _studentModel!.token = token;
    notifyListeners();
  }
}
