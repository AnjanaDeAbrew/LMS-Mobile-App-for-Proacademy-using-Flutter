import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/controllers/enroll_controller.dart';
import 'package:proacademy_lms/models/objects.dart';

class EnrollProvider extends ChangeNotifier {
  //create object of controller class
  final EnrollController _enrollController = EnrollController();

  //----loading state
  bool _isLoading = false;

  //get loader state
  bool get isLoading => _isLoading;

  //-----set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //----get enrollment status
  late EnrollModel _enroll;
  EnrollModel get enrollStatus => _enroll;

  //----save course details to enroll collection
  Future<void> startSaveCourseToEnroll(
    CourseModel courseModel,
    StudentModel studentModel,
    BuildContext context,
  ) async {
    try {
      //-start the loader
      setLoader = true;
      (await _enrollController.saveCourseToEnroll(
          courseModel, studentModel, context));
      notifyListeners();
      //-stop the loader
      setLoader = false;
    } catch (e) {
      //-stop the loader
      setLoader = false;
      Logger().e(e);
    }
  }

  //-------to store selected enrolled course
  late EnrollModel _enrollModel;

  EnrollModel get enrollModel => _enrollModel;

  //set enroll model when clicked on the course tile
  void setEnrollCourse(EnrollModel model) {
    _enrollModel = model;
    notifyListeners();
  }

  //delete enrollment from db
  Future<void> unEnrollCourse(String courseName, String sid) async {
    try {
      //-start the loader
      setLoader = true;

      await _enrollController.unEnrollCourse(courseName, sid);
      //-stop the loader
      setLoader = false;
    } catch (e) {
      //-stop the loader
      setLoader = false;
      Logger().e(e);
    }
  }

  //---------store product list
  final List<EnrollModel> _erl = [];

  List<EnrollModel> get erl => _erl;
}
