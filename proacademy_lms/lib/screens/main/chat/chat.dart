import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/controllers/chat_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/screens/main/chat/widgets/chat_bubble.dart';
import 'package:proacademy_lms/screens/main/chat/widgets/chat_header.dart';
import 'package:proacademy_lms/screens/main/chat/widgets/message_typing_widget.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({
    super.key,
    required this.convId,
  });

  final String convId;
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<MessageModel> _messages = [];
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: SizeConfig.w(context),
          height: SizeConfig.h(context),
          child: Column(
            children: [
              const ChatHeader(),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: ChatController().getMessages(widget.convId),
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

                  _messages.clear();

                  for (var e in snapshot.data!.docs) {
                    Map<String, dynamic> data =
                        e.data() as Map<String, dynamic>;
                    var model = MessageModel.fromJson(data);

                    _messages.add(model);
                  }
                  return Expanded(
                    flex: 100,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //--------------group messages by date and time
                          bool isSameDate = true;
                          final String dateString =
                              _messages[index].messageTime;
                          final DateTime date = DateTime.parse(dateString);

                          if (index == 0) {
                            isSameDate = false;
                          } else {
                            final String prevDateString =
                                _messages[index - 1].messageTime;
                            final DateTime prevDate =
                                DateTime.parse(prevDateString);
                            isSameDate = date.isSameDate(prevDate);
                          }
                          if (index == 0 || !(isSameDate)) {
                            return Column(children: [
                              DateChip(
                                date: date,
                                color: const Color.fromARGB(255, 237, 237, 237),
                              ),
                              Consumer<AuthProvider>(
                                  builder: (context, value, child) {
                                return ChatBubble(
                                  isSender: _messages[index].senderId ==
                                      value.studentModel!.sid,
                                  model: _messages[index],
                                );
                              })
                            ]);
                          } else {
                            return Consumer<AuthProvider>(
                                builder: (context, value, child) {
                              return ChatBubble(
                                isSender: _messages[index].senderId ==
                                    value.studentModel!.sid,
                                model: _messages[index],
                              );
                            });
                          }
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: _messages.length),
                  );
                },
              ),
              const Spacer(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child:
                      MessageTypingWidget(scrollController: scrollController)),
            ],
          ),
        ),
      ),
    );
  }
}

String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
