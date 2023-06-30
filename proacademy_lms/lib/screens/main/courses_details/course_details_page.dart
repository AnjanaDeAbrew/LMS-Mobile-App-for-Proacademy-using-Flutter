import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_button.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/controllers/enroll_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/providers/course/course_provider.dart';
import 'package:proacademy_lms/providers/course/enroll_provider.dart';
import 'package:proacademy_lms/screens/main/student_list/enroll_std_list.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsPage extends StatefulWidget {
  const CourseDetailsPage({super.key});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  bool isCLicked = false;
  @override
  Widget build(BuildContext context) {
    final List<EnrollModel> students = [];
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              width: SizeConfig.w(context),
              color: AppColors.white,
              child: Consumer3<CourseProvider, AuthProvider, EnrollProvider>(
                builder: (context, value, auth, enroll, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //------course banner image
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        height: SizeConfig.h(context) * 0.35,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                              image: NetworkImage(value.courseModel.img),
                              fit: BoxFit.cover),
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () => UtilFunctions.goBack(context),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: AppColors.white.withOpacity(.6),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 22,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      //--------course name
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: SizeConfig.w(context) * 0.6,
                              child: CustomText(value.courseModel.courseName,
                                  fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),

                      //-------language and seesions count
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.computer_rounded,
                              size: 19,
                              color: Color.fromARGB(255, 179, 179, 179),
                            ),
                            const SizedBox(width: 8),
                            CustomText(
                              value.courseModel.language,
                              color: const Color.fromARGB(255, 116, 116, 116),
                            ),
                            const SizedBox(width: 20),
                            const Icon(
                              Icons.play_circle_filled,
                              size: 19,
                              color: Color.fromARGB(255, 179, 179, 179),
                            ),
                            const SizedBox(width: 8),
                            CustomText(
                              '${value.courseModel.session} Sessions',
                              color: const Color.fromARGB(255, 116, 116, 116),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      //-------duration and price tage
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.watch_later,
                              size: 19,
                              color: Color.fromARGB(255, 179, 179, 179),
                            ),
                            const SizedBox(width: 8),
                            CustomText(
                              '${value.courseModel.duration} months',
                              color: const Color.fromARGB(255, 116, 116, 116),
                            ),
                            const Spacer(),
                            Image.network(
                              'https://cdn-icons-png.flaticon.com/128/4000/4000344.png',
                              width: 20,
                              color: AppColors.primaryBlueColor,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 112, 133, 203),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: CustomText(
                                'LKR ${value.courseModel.price} /month',
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      //-------description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomText(
                          value.courseModel.description,
                          fontSize: 14,
                          maxLines: isCLicked ? 8 : 2,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 160, 175, 183),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCLicked = !isCLicked;
                            });
                          },
                          child: CustomText(
                            isCLicked ? "Show Less" : "Read More",
                            color: const Color.fromARGB(255, 106, 105, 105),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      //---------pdf link
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          onTap: () {
                            Uri uri = Uri.parse(value.courseModel.link);
                            launchUrl(uri,
                                mode: LaunchMode.externalNonBrowserApplication);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: SizeConfig.w(context) * 0.5,
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 112, 133, 203)
                              //     .withOpacity(.4),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color.fromARGB(255, 112, 133, 203),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      AssetConstants.pdf,
                                      width: 22,
                                    ),
                                    const SizedBox(width: 10),
                                    const CustomText("Course Content",
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 112, 133, 203)),
                                    const Spacer(),
                                    Image.asset(
                                      AssetConstants.openPdf,
                                      width: 22,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                const CustomText("open course content as a pdf",
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 112, 133, 203)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      //---------students list text button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            UtilFunctions.navigateTo(
                                context, const EnrollStdList());
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.people_alt,
                                color: Color.fromARGB(255, 10, 116, 52),
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  const CustomText("See All Enrolled Students",
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 55, 94, 177)),
                                  const SizedBox(width: 10),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: EnrollController()
                                          .getEnrollStudentsCount(
                                              value.courseModel.courseName),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Center(
                                            child: CustomText(
                                              "",
                                              fontSize: 10,
                                              color: AppColors.kAsh,
                                            ),
                                          );
                                        }

                                        //----------if the stream is still loading
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        students.clear();

                                        for (var e in snapshot.data!.docs) {
                                          Map<String, dynamic> data =
                                              e.data() as Map<String, dynamic>;

                                          var model =
                                              EnrollModel.fromJson(data);

                                          students.add(model);
                                        }
                                        return CustomText(
                                            "(${students.length})",
                                            fontSize: 16,
                                            color: const Color.fromARGB(
                                                255, 55, 94, 177));
                                      })
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 70),

                      //---------enroll button
                      Center(
                        child: CustomButton(
                          text: "Enroll Now",
                          // color: const Color.fromARGB(255, 42, 70, 162),
                          radius: 50,
                          width: SizeConfig.w(context) * 0.8,
                          isLoading: enroll.isLoading,
                          onTap: () {
                            Provider.of<EnrollProvider>(context, listen: false)
                                .startSaveCourseToEnroll(
                              value.courseModel,
                              auth.studentModel!,
                              context,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
