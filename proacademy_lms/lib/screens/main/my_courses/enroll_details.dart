import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_button.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/providers/course/enroll_provider.dart';
import 'package:proacademy_lms/screens/main/my_courses/widgets/videos_list.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class EnrollDetailsPage extends StatefulWidget {
  const EnrollDetailsPage({super.key});

  @override
  State<EnrollDetailsPage> createState() => _EnrollDetailsPageState();
}

class _EnrollDetailsPageState extends State<EnrollDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            width: SizeConfig.w(context),
            // height: SizeConfig.h(context),
            child: Consumer<EnrollProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      height: SizeConfig.h(context) * 0.35,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image:
                                NetworkImage(value.enrollModel.courseModel.img),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: SizeConfig.w(context) * 0.6,
                            child: CustomText(
                                value.enrollModel.courseModel.courseName,
                                fontSize: 24),
                          ),
                          const CustomText(
                            'enrolled',
                            fontSize: 13,
                            color: AppColors.lightGreen,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
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
                            value.enrollModel.courseModel.language,
                            // value.courseModel.language,
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
                            '${value.enrollModel.courseModel.session} Sessions',
                            // '${value.courseModel.session} Sessions',
                            color: const Color.fromARGB(255, 116, 116, 116),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.date_range,
                            size: 19,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: SizeConfig.w(context) * 0.6,
                            child: CustomText(
                              'Strated At ${value.enrollModel.enrolledDate.substring(0, 4)}/${value.enrollModel.enrolledDate.substring(5, 7)}/${value.enrollModel.enrolledDate.substring(8, 10)}',
                              color: const Color.fromARGB(255, 116, 116, 116),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 290,
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 28),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 243, 243, 243),
                              ),
                              child: TabBar(
                                labelColor: AppColors.white,
                                labelStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Creates border
                                  color:
                                      const Color.fromARGB(255, 112, 133, 203),
                                ),
                                tabs: const [
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText('Videos'),
                                      ],
                                    ),
                                  ),
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText('Certificate'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  const VideoList(),
                                  Container(
                                    margin: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://marketplace.canva.com/EAFJXTjgz1M/1/0/1600w/canva-blue-and-yellow-minimalist-employee-of-the-month-certificate-_A_NvKtzEzc.jpg'),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    CustomButton(
                      text: 'Unenroll Now',
                      isLoading: value.isLoading,
                      onTap: () {
                        value.unEnrollCourse(
                            value.enrollModel.courseModel.courseName,
                            value.enrollModel.studentModel.sid);
                        UtilFunctions.goBack(context);
                      },
                      radius: 100,
                      width: SizeConfig.w(context) * 0.7,
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            )),
      ),
    ));
  }
}
