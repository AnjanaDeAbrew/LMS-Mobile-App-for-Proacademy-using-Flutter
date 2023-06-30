import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/controllers/file_upload_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/course/course_provider.dart';
import 'package:proacademy_lms/utils/alert_helper.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:provider/provider.dart';

class AuthController {
  //----signup user
  Future<void> signupUser(
      String email,
      String password,
      String firstName,
      String lastName,
      String birthday,
      int age,
      String mobile,
      String gender,
      String address,
      String school,
      BuildContext context) async {
    try {
      //----start creating the user in the firebase console
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //----------check user object is not null
      if (credential.user != null) {
        //------save extra user data in firestore cloud
        saveUserData(
          credential.user!.uid,
          email,
          firstName,
          lastName,
          birthday,
          age,
          mobile,
          gender,
          address,
          school,
        );
      }
      Logger().i(credential);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      AlertHelper.showAlert(context, "Error", e.code, DialogType.ERROR);
    } catch (e) {
      Logger().e(e);
      AlertHelper.showAlert(context, "Error", e.toString(), DialogType.ERROR);
    }
  }

  //--------============================saving user data in cloud firestore======================
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  CollectionReference allenrolls =
      FirebaseFirestore.instance.collection('allenrolls');

  //----save extra user data in firestore
  Future<void> saveUserData(
    String sid,
    String email,
    String firstName,
    String lastName,
    String birthday,
    int age,
    String mobile,
    String gender,
    String address,
    String school,
  ) {
    return students
        .doc(sid)
        .set(
          {
            'sid': sid,
            'email': email,
            'firstName': firstName,
            'lastName': lastName,
            'birthday': birthday,
            'age': age,
            'mobile': mobile,
            'gender': gender,
            'address': address,
            'school': school,
            'joinedDate': DateTime.now().toString(),
            'img': AssetConstants.profileImgUrl,
            'lastSeen': DateTime.now().toString(),
            'isOnline': true,
            'token': '',
          },
        )
        .then((value) => Logger().i("Successfully added"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  //----login user
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      //----start login in the user in the firebase console
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger().i(credential);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      AlertHelper.showAlert(context, "Error", e.code, DialogType.ERROR);
    } catch (e) {
      Logger().e(e);
      AlertHelper.showAlert(context, "Error", e.toString(), DialogType.ERROR);
    }
  }

  //---trigger logging out
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  //----reset password email
  static Future<void> sendResetPassEmail(
      String email, BuildContext context) async {
    try {
      //----start sending apassword reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      AlertHelper.showAlert(context, "Error", e.code, DialogType.ERROR);
    } catch (e) {
      Logger().e(e);
      AlertHelper.showAlert(context, "Error", e.toString(), DialogType.ERROR);
    }
  }

  //---fetch student data from cloudfirestore

  Future<StudentModel?> fetchUserData(String sid) async {
    try {
      //----------------firebase query that find and fetch user data according to the uid
      DocumentSnapshot documentSnapshot = await students.doc(sid).get();
      Logger().i(documentSnapshot.data());

      //---mapping fetched data user data into usermodel
      StudentModel model = StudentModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);

      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //===================================upload user image
  final FileUploadController _fileUploadController = FileUploadController();

//---------upload picked image file to firebase storage
  Future<String> uploadAndUpdatePickedImage(
      File file, String sid, BuildContext context) async {
    try {
      //------first upload and get the download link of he picked file
      String downloadUrl =
          await _fileUploadController.uploadFile(file, "profileImages");

      if (downloadUrl != "") {
        //------updating the uploaded file download url in the user data
        await students.doc(sid).update(
          {
            'img': downloadUrl,
          },
        ).then((value) async {
          updateEverywhereStudentProfileImg(sid, context, downloadUrl);
        });

        return downloadUrl;
      } else {
        Logger().e("download url is empty");
        return "";
      }
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }

//----update profile image of students in enrollments
  Future<void> updateEverywhereStudentProfileImg(
      String sid, BuildContext context, String url) async {
    try {
      QuerySnapshot result =
          await allenrolls.where('studentModel.sid', isEqualTo: sid).get();

      for (int i = 0; i < result.docs.length; i++) {
        String id = sid +
            // ignore: use_build_context_synchronously
            Provider.of<CourseProvider>(context, listen: false)
                .courses[i]
                .courseName;
        await allenrolls.doc(id).update(
          {
            'studentModel.img': url,
          },
        );
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //-update the current user online state and last seen
  Future<void> updateOnlineStates(
      String sid, bool isOnline, BuildContext context) async {
    await students
        .doc(sid)
        .update({
          "isOnline": isOnline,
          "lastSeen": DateTime.now().toString(),
        })
        .then((value) =>
            updateEveryWhereStudentOnlineStatus(sid, context, isOnline))
        .then((value) => Logger().i("Online Status updated"))
        .catchError((error) => Logger().e("Failed to update : $error"));
  }

  //----update profile image of students in enrollments
  Future<void> updateEveryWhereStudentOnlineStatus(
      String sid, BuildContext context, bool isOnline) async {
    try {
      QuerySnapshot result =
          await allenrolls.where('studentModel.sid', isEqualTo: sid).get();

      for (int i = 0; i < result.docs.length; i++) {
        String id = sid +
            // ignore: use_build_context_synchronously
            Provider.of<CourseProvider>(context, listen: false)
                .courses[i]
                .courseName;
        await allenrolls.doc(id).update(
          {
            "studentModel.isOnline": isOnline,
            "studentModel.lastSeen": DateTime.now().toString(),
          },
        );
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
