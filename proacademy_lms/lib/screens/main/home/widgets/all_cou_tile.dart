import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/custom_text_heebo.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/course/course_provider.dart';
import 'package:proacademy_lms/screens/main/courses_details/course_details_page.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_colors.dart';

class AllCourseTile extends StatelessWidget {
  const AllCourseTile({
    super.key,
    required this.courseModel,
  });
  final CourseModel courseModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        //---first set the product model
        Provider.of<CourseProvider>(context, listen: false).setCourse =
            courseModel;
        //----after anvigate
        UtilFunctions.navigateTo(context, const CourseDetailsPage());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                  color: AppColors.ashBorder,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                        courseModel.img,
                      ),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(),
              child: CustomText(
                courseModel.courseName,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(),
              child: CustomTextHeebo(
                courseModel.language,
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
