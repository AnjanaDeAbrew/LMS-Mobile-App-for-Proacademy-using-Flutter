import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/controllers/course_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/utils/util_functions.dart';

class CourseProvider extends ChangeNotifier {
  //------admin controller object
  final CourseController _admiController = CourseController();
  //------product image object
  File _image = File("");

  //----get picked file
  File get image => _image;
  //--select product image
  Future<void> selectImage() async {
    try {
      _image = (await UtilFunctions.pickImageFromGallery())!;
    } catch (e) {
      Logger().e(e);
    }
  }

  //---CourseName controller
  final _courseName = TextEditingController();
  //--- get ProductName controller
  TextEditingController get courseNameController => _courseName;

  //---ProductName controller
  final _langName = TextEditingController();
  //--- get ProductName controller
  TextEditingController get langNameController => _langName;

  //---description controler
  final _description = TextEditingController();
  //--- get description controller
  TextEditingController get descriptionController => _description;

  //----price controller
  final _price = TextEditingController();
  //--- get price controller
  TextEditingController get priceController => _price;

  //----session controller
  final _session = TextEditingController();
  //--- get session controller
  TextEditingController get sessionController => _session;

  //----duration controller
  final _duration = TextEditingController();
  //--- get duration controller
  TextEditingController get durationController => _duration;

//----link controller
  final _link = TextEditingController();
  //--- get link controller
  TextEditingController get linkController => _link;

  //----loading state
  bool _isLoading = false;

  //get loader state
  bool get isLoading => _isLoading;

  //-----set loading state
  set setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //-start saving product data
  Future<void> startSaveProductData() async {
    try {
      //-start the loader
      setLoader = true;
      await _admiController
          .saveProductData(
        _courseName.text,
        _langName.text,
        _description.text,
        _price.text,
        _session.text,
        _duration.text,
        _link.text,
        _image,
      )
          .then((value) {
        //--clean values
        _courseName.clear();
        _langName.clear();
        _description.clear();
        _price.clear();
        _session.clear();
        _duration.clear();
        _link.clear();
        _image = File("");
      });
      //-stop the loader
      setLoader = false;
    } catch (e) {
      //-stop the loader
      setLoader = false;
      Logger().e(e);
    }
  }

  //---------store product list
  List<CourseModel> _courses = [];

  List<CourseModel> get courses => _courses;

  //---start fetch products
  Future<void> startFetchProducts() async {
    try {
      //-start the loader
      setLoader = true;
      _courses = await _admiController.fetchCourseList();
      notifyListeners();
      //-stop the loader
      setLoader = false;
    } catch (e) {
      Logger().e(e);
      //-stop the loader
      setLoader = false;
    }
  }

//-------to store selected course
  late CourseModel _courseModel;

  CourseModel get courseModel => _courseModel;

  //set course model when clicked on the course tile
  set setCourse(CourseModel model) {
    _courseModel = model;
    notifyListeners();
  }
}
