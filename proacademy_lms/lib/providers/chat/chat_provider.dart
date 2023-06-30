import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/controllers/chat_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/screens/main/chat/chat.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final ChatController _chatController = ChatController();

  int _loadingIndex = -1;
  int get loadingIndex => _loadingIndex;
  void setLoadingIndex([int i = -1]) {
    //---assign default -1 to auto stop the loader. {} or [] can use defualt value
    _loadingIndex = i;
    notifyListeners();
  }

  //-conversation model
  late ConversationModel _conversationModel;
  ConversationModel get conversationModel => _conversationModel;
  //-set model
  void setConversation(ConversationModel model) {
    _conversationModel = model;
    notifyListeners();
  }

//-start create the conversation
  Future<void> startCreateConversation(
      BuildContext context, StudentModel peeruser, int i) async {
    try {
      StudentModel me =
          Provider.of<AuthProvider>(context, listen: false).studentModel!;
      //---start the loader
      setLoadingIndex(i);
      _conversationModel =
          await _chatController.createConersation(me, peeruser);
      notifyListeners();

      //-stop the loader
      setLoadingIndex();

      //-navigate the user to the chat screen after creating the conversation
      // ignore: use_build_context_synchronously
      UtilFunctions.navigateTo(
          context,
          Chat(
            convId: _conversationModel.id,
          ));
    } catch (e) {
      setLoadingIndex();
      Logger().e(e);
    }
  }

  Future<void> startSendMessage(
      BuildContext context, String message, String type) async {
    try {
      StudentModel me =
          Provider.of<AuthProvider>(context, listen: false).studentModel!;
      //-save message in db
      await _chatController.sendMessage(
        _conversationModel.id,
        me.firstName,
        me.sid,
        _peerUser.sid,
        message,
        _peerUser.token,
        type,
      );
    } catch (e) {
      Logger().e(e);
    }
  }

  //-peer user model
  late StudentModel _peerUser;

  StudentModel get peerUser => _peerUser;

  void setPeerUser(StudentModel model) {
    _peerUser = model;
  }

  //-conversation list
  List<ConversationModel> _convList = [];

  List<ConversationModel> get convList => _convList;

  void setConvList(List<ConversationModel> list) {
    _convList = list;
  }

  //----set conversation model and user to chat screen when notification is clicked
  void setNotificationData(BuildContext context, String id) {
    try {
      //-find and set conv and model
      ConversationModel temp = _convList.firstWhere((e) => e.id == id);

      setConversation(temp);
      //-navigate the user to chat screen
      UtilFunctions.navigateTo(context, Chat(convId: id));
    } catch (e) {
      Logger().e(e);
    }
  }

//------product image object
  File _image = File("");

  //----get picked file
  File get image => _image;

  final String _imgUrl = '';
  String get imgUrl => _imgUrl;

  // //---------------method to profile image
  Future<void> getImageFromCamera(BuildContext context) async {
    try {
      _image = (await UtilFunctions.pickImageFromCamera())!;
      if (_image.path != "") {
        await _chatController
            .uploadAndUpdatePickedImage(_image)
            .then((value) => startSendMessage(context, value, 'image'));

        // notifyListeners();
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    try {
      _image = (await UtilFunctions.pickImageFromGallery())!;
      if (_image.path != "") {
        await _chatController
            .uploadAndUpdatePickedImage(_image)
            .then((value) => startSendMessage(context, value, 'image'));

        // notifyListeners();
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void deleteMessage(String messageId) {
    _chatController.deleteBooking(messageId);
    notifyListeners();
  }
}
