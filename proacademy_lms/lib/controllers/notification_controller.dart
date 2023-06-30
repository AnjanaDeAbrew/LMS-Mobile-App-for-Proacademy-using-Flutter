import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class NotificationController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  //-save students device token in the students data
  Future<void> saveNotificationoken(String sid, String token) async {
    await students
        .doc(sid)
        .update(
          {
            'token': token,
          },
        )
        .then((value) => Logger().i("Device token updated"))
        .catchError((error) => Logger().e("Failed to update token: $error"));
  }
}
