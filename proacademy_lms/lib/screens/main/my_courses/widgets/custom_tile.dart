import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/custom_text_heebo.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/course/enroll_provider.dart';
import 'package:proacademy_lms/screens/main/my_courses/enroll_details.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_colors.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({
    super.key,
    required this.model,
  });
  final EnrollModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        //-first set the model
        Provider.of<EnrollProvider>(context, listen: false)
            .setEnrollCourse(model);
        UtilFunctions.navigateTo(
            context, ZoomIn(child: const EnrollDetailsPage()));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5,
                  color: AppColors.ashBorder,
                  offset: Offset(0, 5)),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: SizeConfig.w(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                        model.courseModel.img,
                      ),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(),
              child: CustomText(
                model.courseModel.courseName,
                fontSize: 18,
                // color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(),
              child: CustomTextHeebo(
                model.courseModel.language,
                fontSize: 14,
                // color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
