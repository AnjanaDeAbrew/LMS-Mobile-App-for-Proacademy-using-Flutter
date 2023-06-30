import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/search_bar.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/screens/main/home/lists/all_course_list.dart';
import 'package:proacademy_lms/screens/main/home/lists/home_enrolled_course_list.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: SizeConfig.w(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                // UtilFunctions.navigateTo(
                                //     context, const Admin());
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage(value.studentModel!.img),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  "Hello ${value.studentModel!.firstName}!",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                                const CustomText(
                                  "Welcome to Proacademy",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.kAsh,
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    )),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: CustomSearchBar(),
                ),
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: CustomText(
                    "Enrolled Courses",
                    color: AppColors.primaryBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 2),
                  child: SizedBox(
                      width: SizeConfig.w(context),
                      height: 240,
                      child: const EnrollList()),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 22,
                  ),
                  child: CustomText(
                    "All Courses",
                    color: AppColors.primaryBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 2),
                  child: SizedBox(
                      width: SizeConfig.w(context),
                      height: 270,
                      child: const AllCourseList()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
