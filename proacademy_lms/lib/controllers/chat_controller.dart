import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/controllers/file_upload_controller.dart';
import 'package:proacademy_lms/models/objects.dart';

class ChatController {
  // Create a CollectionReference called conversations that references the firestore collection
  CollectionReference conversations =
      FirebaseFirestore.instance.collection('conversations');

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  //-create object from file upload class
  final FileUploadController _fileUploadController = FileUploadController();

  //----------retreive conversation stream
  Stream<QuerySnapshot> getUsers(String currentUserId) =>
      students.where('uid', isNotEqualTo: currentUserId).snapshots();

  // //----create converstaion in firestore
  Future<ConversationModel> createConersation(
      StudentModel me, StudentModel peeruser) async {
    //-check conversation exists
    ConversationModel? model = await checkConvExist(me.sid, peeruser.sid);

    if (model == null) {
      String docId = conversations.doc().id;

      await conversations
          .doc(docId)
          .set(
            {
              'id': docId,
              'students': [me.sid, peeruser.sid],
              'studentArray': [
                me.toJson(),
                peeruser.toJson()
              ], //---to filter conversations via stream
              'lastMessage': "started the conversation",
              'lastMessageTime': DateTime.now().toString(),
              'createdBy': me.sid,
              'createdAt': DateTime.now(),
              'messageType': "text",
            },
          )
          .then((value) => Logger().i("Conversation added"))
          .catchError((error) => Logger().e("Failed to merge data: $error"));

      DocumentSnapshot snapshot = await conversations.doc(docId).get();
      return ConversationModel.fromJson(
          snapshot.data() as Map<String, dynamic>);
    } else {
      return model;
    }
  }

  Future<ConversationModel?> checkConvExist(String myId, String peerId) async {
    try {
      ConversationModel? conModel;
      QuerySnapshot result = await conversations
          .where('students', arrayContainsAny: [myId, peerId]).get();
      Logger().wtf(result.docs.length);

      for (var e in result.docs) {
        var model =
            ConversationModel.fromJson(e.data() as Map<String, dynamic>);

        if (model.students.contains(myId) && model.students.contains(peerId)) {
          Logger().w("the conversation is already exists");
          conModel = model;
          return conModel;
        } else {
          Logger().w("the conversation is not exists");
          conModel = null;
        }
      }
      return conModel;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //----------retreive conversation stream
  Stream<QuerySnapshot> getConversations(String currentUserId) => conversations
      .orderBy('createdAt', descending: true)
      .where('students', arrayContainsAny: [currentUserId]).snapshots();

  //-message sent fuction
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  Future<void> sendMessage(String conId, String senderName, String senderId,
      String reciveId, String message, String recivertoken, String type) async {
    String docId = messages.doc().id;
    try {
      await messages.doc(docId).set({
        "messageId": docId,
        "conId": conId,
        "senderName": senderName,
        "senderId": senderId,
        "reciveId": reciveId,
        "message": message,
        "messageTime": DateTime.now().toString(),
        "recivertoken": recivertoken,
        "createdAt": DateTime.now(),
        "messageType": type,
      });

      if (type == 'image') {
        await conversations.doc(conId).update({
          'messageType': "image",
        });
      }
      if (type == 'text') {
        await conversations.doc(conId).update({
          'messageType': "text",
        });
      }
      //----update the conversation lastmesage
      await conversations.doc(conId).update({
        'lastMessage': message,
        'lastMessageTime': DateTime.now().toString(),
        'createdAt': DateTime.now()
      });
    } catch (e) {
      Logger().e(e);
    }
  }

//---------upload picked image file to firebase storage
  Future<String> uploadAndUpdatePickedImage(
    file,
  ) async {
    try {
      //------first upload and get the download link of he picked file
      String downloadUrl =
          await _fileUploadController.uploadFile(file, "messageImages");

      if (downloadUrl != "") {
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

  //----------retreive message stream
  Stream<QuerySnapshot> getMessages(String conId) => messages
      .orderBy('createdAt', descending: false)
      .where('conId', isEqualTo: conId)
      .snapshots();

  //----------listen to peer user uid
  Stream<DocumentSnapshot> getPeerUserOnlineStatus(String sid) =>
      students.doc(sid).snapshots();

  Future<void> deleteBooking(String id) async {
    await messages.doc(id).delete();
  }
}
