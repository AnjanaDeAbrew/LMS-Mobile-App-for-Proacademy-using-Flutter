import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/controllers/file_upload_controller.dart';
import 'package:proacademy_lms/models/objects.dart';

class CourseController {
//--------============================saving user data in cloud firestore======================
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  //------file upload controller object
  final FileUploadController _fileUploadController = FileUploadController();

  //----save product data in firestore
  Future<void> saveProductData(
      String courseName,
      String language,
      String desc,
      String price,
      String seesion,
      String duration,
      String link,
      File file) async {
    //--------uploading the selected product image in storage and get the downloaded url first
    final String downloadUrl =
        await _fileUploadController.uploadFile(file, "productImages");
    if (downloadUrl != "") {
      await courses
          .add(
            {
              'courseName': courseName,
              'language': language,
              'description': desc,
              'price': price,
              'session': seesion,
              'duration': duration,
              'link': link,
              'img': downloadUrl,
            },
          )
          .then((value) => Logger().i("Course added"))
          .catchError((error) => Logger().e("Failed to add product: $error"));
    } else {
      Logger().e("No Product Image selected");
    }
  }

  //---fetch product list from cloudfirestore

  Future<List<CourseModel>> fetchCourseList() async {
    try {
      //----------------firebase query that find and fetch product collection
      QuerySnapshot querySnapshot = await courses.get();

      Logger().i(querySnapshot.docs.length);

      //temp product list
      List<CourseModel> list = [];

      for (var e in querySnapshot.docs) {
        CourseModel model =
            CourseModel.fromJson(e.data() as Map<String, dynamic>);

        //---adding to the product list
        list.add(model);
      }

      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
