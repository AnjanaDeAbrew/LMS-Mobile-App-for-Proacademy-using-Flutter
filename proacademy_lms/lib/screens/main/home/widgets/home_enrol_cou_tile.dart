import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/custom_text_heebo.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/course/enroll_provider.dart';
import 'package:proacademy_lms/screens/main/my_courses/enroll_details.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class EnrollTile extends StatelessWidget {
  const EnrollTile({
    super.key,
    required this.model,
    required this.index,
  });
  final EnrollModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://images.unsplash.com/photo-1520962922320-2038eebab146?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8bmF0dXJhbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1535463731090-e34f4b5098c5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjN8fG5hdHVyYWx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1493246507139-91e8fad9978e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8OXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1500375592092-40eb2168fd21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      'https://images.unsplash.com/photo-1482685945432-29a7abf2f466?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    ];
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        //---set enroll course first
        Provider.of<EnrollProvider>(context, listen: false)
            .setEnrollCourse(model);
        UtilFunctions.navigateTo(context, const EnrollDetailsPage());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                  // gradient: LinearGradient(colors: [
                  //   Color(Random().nextInt(0xffF49F84)),
                  //   Color(Random().nextInt(0xffF49F84))
                  // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),

                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                        images[index],
                      ),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 190),
              child: CustomText(
                model.courseModel.courseName,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(),
              child: CustomTextHeebo(
                model.courseModel.language,
                fontSize: 13,
                color: AppColors.kAsh,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
