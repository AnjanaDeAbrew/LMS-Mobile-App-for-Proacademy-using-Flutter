import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/utils/app_colors.dart';

class VideoList extends StatelessWidget {
  const VideoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.play_circle_rounded,
            size: 50,
            color: Color.fromARGB(255, 112, 133, 203),
          ),
          title: CustomText(
            "Session Topic ${index + 1}",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          subtitle: CustomText(
            "${index + 2} Min ${index + 18} Sec",
            fontSize: 13,
            color: AppColors.kAsh,
          ),
          trailing: const CircleAvatar(
            backgroundColor: Color(0xffFEE9C5),
            child: Icon(
              Icons.lock,
              size: 20,
              color: Color(0xffF8AE2D),
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }
}
