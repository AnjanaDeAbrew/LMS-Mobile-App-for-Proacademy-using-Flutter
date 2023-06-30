import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/utils/alert_helper.dart';

class EnrollController {
  //--------============================saving user data in cloud firestore======================
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference enrollments =
      FirebaseFirestore.instance.collection('enrollments');
  CollectionReference allenrolls =
      FirebaseFirestore.instance.collection('allenrolls');

  late DocumentReference _documentReference;
  late CollectionReference _collectionReference;

  Future<void> saveCourseToEnroll(
    CourseModel courseModel,
    StudentModel studentModel,
    BuildContext context,
  ) async {
    //-check already enroll or not
    EnrollModel? model =
        await checkAlreadyEnrolled(courseModel, studentModel, context);
    if (model == null) {
      await enrollments.doc(studentModel.sid).set({
        'studentModel': studentModel.toJson(),
      });
      _documentReference = enrollments.doc(studentModel.sid);
      _collectionReference = _documentReference.collection("enrollCourses");
      _collectionReference
          .doc(courseModel.courseName)
          .set({
            'studentModel': studentModel.toJson(),
            'courseModel': courseModel.toJson(),
            'enrolledDate': DateTime.now().toString(),
            'language': courseModel.language,
          })
          .then((value) => Logger().i("Enrolled added"))
          .then((value) async {
            String docId = studentModel.sid + courseModel.courseName;
            await allenrolls.doc(docId).set({
              'studentModel': studentModel.toJson(),
              'courseModel': courseModel.toJson(),
              'enrolledDate': DateTime.now().toString(),
              'language': courseModel.language,
            });
          })
          // ignore: invalid_return_type_for_catch_error
          .catchError((error) => Logger().e("Failed to merge data: $error"));
    }
  }

  Future<EnrollModel?> checkAlreadyEnrolled(CourseModel courseModel,
      StudentModel studentModel, BuildContext context) async {
    try {
      EnrollModel? enrollmentModel;
      QuerySnapshot result = await enrollments
          .doc(studentModel.sid)
          .collection('enrollCourses')
          .get();

      for (var e in result.docs) {
        var model = EnrollModel.fromJson(e.data() as Map<String, dynamic>);

        if (model.courseModel.courseName == courseModel.courseName &&
            model.studentModel.sid == studentModel.sid) {
          enrollmentModel = model;
          // ignore: use_build_context_synchronously
          AlertHelper.showAlert(
              context,
              'Already Enrolled',
              "${studentModel.firstName}, You have already enrolled for the ${courseModel.courseName}",
              DialogType.WARNING);
          Logger().w("You have already enrolled for this course");
        } else {
          Logger().w("You have not enrolled yet");
          enrollmentModel = null;
        }
      }
      return enrollmentModel;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //stream query for fetch enroll data
  Stream<QuerySnapshot> getEnrollments(String sid) =>
      enrollments.doc(sid).collection('enrollCourses').snapshots();

  //delete enrollcourse from db
  Future<void> unEnrollCourse(String courseName, String sid) async {
    await enrollments
        .doc(sid)
        .collection('enrollCourses')
        .doc(courseName)
        .delete()
        .then((value) async {
      String docId = sid + courseName;
      await allenrolls.doc(docId).delete();
    });
  }

  //stream query for fetch enroll data
  Stream<QuerySnapshot> getEnrollStudentsCount(String courseName) => allenrolls
      .where('courseModel.courseName', isEqualTo: courseName)
      .snapshots();
}
