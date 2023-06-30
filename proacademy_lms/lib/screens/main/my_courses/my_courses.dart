import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/controllers/enroll_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/screens/main/my_courses/widgets/custom_tile.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:provider/provider.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  @override
  Widget build(BuildContext context) {
    //-list for enrollments
    final List<EnrollModel> enrollments = [];
    //---Student model
    StudentModel studentModel =
        Provider.of<AuthProvider>(context, listen: false).studentModel!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 249, 243),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: const CustomText(
            "My Courses",
            fontSize: 25,
          ),
          actions: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(studentModel.img),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: Container(
          width: SizeConfig.w(context),
          height: SizeConfig.h(context),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              const CustomText(
                "Enreolled",
                fontSize: 20,
                color: AppColors.primaryBlueColor,
              ),
              const SizedBox(height: 25),
              StreamBuilder<QuerySnapshot>(
                  stream: EnrollController().getEnrollments(studentModel.sid),
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
                      return Container();
                    }
                    enrollments.clear();

                    for (var e in snapshot.data!.docs) {
                      Map<String, dynamic> data =
                          e.data() as Map<String, dynamic>;
                      var model = EnrollModel.fromJson(data);

                      enrollments.add(model);
                    }

                    return enrollments.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  AssetConstants.noData,
                                  width: SizeConfig.w(context) * 0.6,
                                  opacity: const AlwaysStoppedAnimation(.4),
                                ),
                                const SizedBox(height: 10),
                                const CustomText(
                                  "Oops! No Enrollments Yet",
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 203, 203, 203),
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) =>
                                    CourseTile(model: enrollments[index]),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 30),
                                itemCount: enrollments.length));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
