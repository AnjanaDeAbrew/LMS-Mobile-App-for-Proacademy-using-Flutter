import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/controllers/chat_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/providers/chat/chat_provider.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer2<ChatProvider, AuthProvider>(
      builder: (context, value, auth, child) {
        var temp = value.conversationModel.studentArray
            .firstWhere((e) => e.sid != auth.studentModel!.sid);
        return StreamBuilder<DocumentSnapshot>(
            stream: ChatController().getPeerUserOnlineStatus(temp.sid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: CustomText(
                    "No messages, error occured",
                    fontSize: 20,
                    color: AppColors.ashBorder,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              StudentModel model = StudentModel.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>);

              value.setPeerUser(model);
              return AppBar(
                toolbarHeight: 70,
                elevation: 0,
                scrolledUnderElevation: 0,
                backgroundColor: Colors.transparent,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(model.img),
                      radius: 20,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.45,
                          child: CustomText(
                            model.firstName,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            // color: AppColors.kBlack,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        CustomText(
                          model.isOnline
                              ? "online"
                              : "last seen ${UtilFunctions.getTimeAgo(model.lastSeen)}",
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kAsh,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        AssetConstants.camIcon,
                        color: const Color.fromARGB(255, 169, 169, 169),
                        width: 28,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        AssetConstants.phoneIcon,
                        color: const Color.fromARGB(255, 164, 164, 164),
                        width: 20,
                      ))
                ],
              );
            });
      },
    );
  }
}
