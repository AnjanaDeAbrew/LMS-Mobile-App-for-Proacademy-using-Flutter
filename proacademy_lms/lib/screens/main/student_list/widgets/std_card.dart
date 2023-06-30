import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/providers/chat/chat_provider.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class StudentsCard extends StatelessWidget {
  const StudentsCard({
    super.key,
    required this.model,
    required this.index,
  });

  final StudentModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      height: 85,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (model.isOnline)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: 45, end: 3),
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: Colors.green,
                      padding: EdgeInsets.all(7),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.ashBorder,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(model.img),
                          radius: 26,
                        ),
                      ),
                    ),
                  ),
                if (!model.isOnline)
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.img),
                    radius: 26,
                  ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190,
                          child: CustomText(
                            '${model.firstName} ${model.lastName} ',
                            textOverflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      model.isOnline
                          ? "online"
                          : UtilFunctions.getTimeAgo(model.lastSeen),
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.left,
                      color: AppColors.kAsh,
                    )
                  ],
                ),
              ],
            ),
            model.sid !=
                    Provider.of<AuthProvider>(context, listen: false)
                        .studentModel!
                        .sid
                ? Consumer<ChatProvider>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                          onPressed: () {
                            value.startCreateConversation(
                                context, model, index);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: value.loadingIndex == index
                                  ? Colors.white
                                  : AppColors.primaryBlueColor),
                          child: value.loadingIndex == index
                              ? const SpinKitWave(
                                  color: AppColors.primaryBlueColor,
                                  size: 10,
                                )
                              : const CustomText(
                                  "chat",
                                  fontSize: 15,
                                  color: AppColors.white,
                                ));
                    },
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryBlueColor),
                        borderRadius: BorderRadius.circular(50)),
                    child: const CustomText(
                      "You",
                      color: AppColors.primaryBlueColor,
                    ),
                  ),
          ]),
    );
  }
}
