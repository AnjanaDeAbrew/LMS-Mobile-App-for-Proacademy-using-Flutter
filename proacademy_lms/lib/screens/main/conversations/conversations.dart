import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/controllers/chat_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/providers/chat/chat_provider.dart';
import 'package:proacademy_lms/screens/main/conversations/widgets/conversation_card.dart';
import 'package:proacademy_lms/screens/main/conversations/widgets/header.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:provider/provider.dart';

class Conversations extends StatefulWidget {
  const Conversations({super.key});

  @override
  State<Conversations> createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  final List<ConversationModel> _conversations = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          child: Consumer<AuthProvider>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Builder(builder: (context) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(value.studentModel!.img),
                            radius: 25,
                          ),
                        );
                      }),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'Hello, ${value.studentModel!.firstName} ',
                            fontSize: 14,
                          ),
                          const Header(text: "Message"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: StreamBuilder<Object>(
                        stream: null,
                        builder: (context, snapshot) {
                          return Consumer<AuthProvider>(
                            builder: (context, value, child) {
                              return StreamBuilder<QuerySnapshot>(
                                stream: ChatController()
                                    .getConversations(value.studentModel!.sid),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: CustomText(
                                        "No conversations, error occured",
                                        fontSize: 20,
                                        color: AppColors.ashBorder,
                                      ),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.data!.docs.isEmpty) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AssetConstants.noChats,
                                            width: SizeConfig.w(context) * 0.5,
                                            opacity:
                                                const AlwaysStoppedAnimation(
                                                    .4),
                                          ),
                                          const SizedBox(height: 10),
                                          const CustomText(
                                            "No Conversations Start Yet !",
                                            fontSize: 25,
                                            color: Color.fromARGB(
                                                255, 203, 203, 203),
                                          )
                                        ],
                                      ),
                                    );
                                  }

                                  _conversations.clear();

                                  for (var e in snapshot.data!.docs) {
                                    Map<String, dynamic> data =
                                        e.data() as Map<String, dynamic>;
                                    var model =
                                        ConversationModel.fromJson(data);

                                    _conversations.add(model);
                                  }
                                  Provider.of<ChatProvider>(context,
                                          listen: false)
                                      .setConvList(_conversations);

                                  return ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) =>
                                          ConversationCard(
                                              model: _conversations[index]),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 1),
                                      itemCount: _conversations.length);
                                },
                              );
                            },
                          );
                        }),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
