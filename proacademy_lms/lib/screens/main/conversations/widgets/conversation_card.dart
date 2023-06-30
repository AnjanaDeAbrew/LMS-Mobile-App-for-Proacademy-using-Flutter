import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/providers/chat/chat_provider.dart';
import 'package:proacademy_lms/screens/main/chat/chat.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class ConversationCard extends StatefulWidget {
  const ConversationCard({
    super.key,
    required this.model,
  });

  final ConversationModel model;

  @override
  State<ConversationCard> createState() => _ConversationCardState();
}

class _ConversationCardState extends State<ConversationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      //----set conversation model before going to the chat screen
      Provider.of<ChatProvider>(context, listen: false)
          .setConversation(widget.model);

      //------then go to the chat screen
      UtilFunctions.navigateTo(context, Chat(convId: widget.model.id));
    }, child: Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.model.studentArray
                  .firstWhere((e) => e.sid != value.studentModel!.sid)
                  .img),
              radius: 26,
            ),
            title: CustomText(
              widget.model.studentArray
                  .firstWhere((e) => e.sid != value.studentModel!.sid)
                  .firstName,
              textOverflow: TextOverflow.ellipsis,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            subtitle: widget.model.messageType == 'image'
                ? const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.done_all,
                        size: 16,
                        color: AppColors.ashBorder,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.image,
                        size: 18,
                        color: AppColors.kAsh,
                      ),
                      SizedBox(width: 5),
                      CustomText(
                        'Photo',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                        color: AppColors.ashBorder,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const Icon(
                        Icons.done_all,
                        size: 16,
                        color: AppColors.ashBorder,
                      ),
                      const SizedBox(width: 5),
                      CustomText(
                        widget.model.lastMessage,
                        textOverflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                        color: AppColors.ashBorder,
                      ),
                    ],
                  ),
            trailing: CustomText(widget.model.lastMessageTime.substring(11, 16),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.kAsh),
          ),
        );
      },
    )

        // ),
        );
  }
}
