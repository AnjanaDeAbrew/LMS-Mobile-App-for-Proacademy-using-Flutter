import 'package:flutter/material.dart';
import 'package:proacademy_lms/providers/chat/chat_provider.dart';
import 'package:proacademy_lms/screens/main/chat/widgets/custom_bar.dart';
import 'package:provider/provider.dart';

class MessageTypingWidget extends StatefulWidget {
  const MessageTypingWidget({
    super.key,
    required this.scrollController,
  });
  final ScrollController scrollController;
  @override
  State<MessageTypingWidget> createState() => _MessageTypingWidgetState();
}

class _MessageTypingWidgetState extends State<MessageTypingWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomMessageBar(
      onSend: (String msg) {
        if (msg.trim().isNotEmpty) {
          Provider.of<ChatProvider>(context, listen: false)
              .startSendMessage(context, msg, 'text');
        }

        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      },
      messageBarColor: Colors.transparent,
      sendButtonColor: const Color.fromARGB(255, 89, 45, 202),
    );
  }
}
