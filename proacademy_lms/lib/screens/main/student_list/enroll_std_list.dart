import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/controllers/enroll_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/providers/course/course_provider.dart';
import 'package:proacademy_lms/screens/main/student_list/widgets/std_card.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class EnrollStdList extends StatefulWidget {
  const EnrollStdList({super.key});

  @override
  State<EnrollStdList> createState() => _EnrollStdListState();
}

class _EnrollStdListState extends State<EnrollStdList> {
  @override
  Widget build(BuildContext context) {
    final List<EnrollModel> students = [];
    return SafeArea(
        child: Scaffold(body: Consumer2<CourseProvider, AuthProvider>(
      builder: (context, value, auth, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: EnrollController()
                .getEnrollStudentsCount(value.courseModel.courseName),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: CustomText(
                    "No Users. Error occured",
                    fontSize: 20,
                    color: AppColors.kAsh,
                  ),
                );
              }

              //----------if the stream is still loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return customContainer(
                    value.courseModel.img, value.courseModel.courseName);
              }
              // Logger().w(snapshot.data!.docs.length);

              students.clear();

              //-read the document list and ,apping them to user model and then add them to the list
              for (var e in snapshot.data!.docs) {
                Map<String, dynamic> data = e.data() as Map<String, dynamic>;

                var model = EnrollModel.fromJson(data);
                // if (model.studentModel.sid != auth.studentModel!.sid) {
                //   students.add(model);
                // }
                students.add(model);
              }

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 200,
                    iconTheme: const IconThemeData(color: AppColors.white),
                    backgroundColor: AppColors.primaryBlueColor.withOpacity(.5),
                    scrolledUnderElevation: 0,
                    leading: IconButton(
                        onPressed: () {
                          UtilFunctions.goBack(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Align(
                        child: CustomText(
                          "Student List",
                          fontSize: 20,
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      centerTitle: true,
                      titlePadding: const EdgeInsets.symmetric(vertical: 10),
                      background: Image.network(
                        value.courseModel.img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: CustomText(
                        value.courseModel.courseName,
                        fontSize: 22,
                        color: AppColors.primaryBlueColor,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => StudentsCard(
                          index: index, model: students[index].studentModel),
                      childCount: students.length,
                    ),
                  ),
                ],
              );
            });
      },
    )));
  }

  Column customContainer(String img, String name) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: SizeConfig.w(context),
            height: 200,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      UtilFunctions.goBack(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.white,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: CustomText(
              name,
              fontSize: 22,
              color: AppColors.primaryBlueColor,
            ),
          ),
          const SizedBox(height: 100),
          Center(
              child: Image.asset(
            AssetConstants.noStd,
            opacity: const AlwaysStoppedAnimation(.3),
          )),
          const Center(
              child: CustomText(
            "No Students Have Enrolled Yet",
            color: AppColors.ashBorder,
            fontSize: 20,
          )),
        ],
      );
}
