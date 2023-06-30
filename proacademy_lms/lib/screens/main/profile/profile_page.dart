import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/custom_text_heebo.dart';
import 'package:proacademy_lms/controllers/auth_controller.dart';
import 'package:proacademy_lms/controllers/enroll_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/providers/course/course_provider.dart';
import 'package:proacademy_lms/screens/main/profile/general_page.dart';
import 'package:proacademy_lms/screens/main/profile/widgets/contact_container.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final List<EnrollModel> enrolls = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const CustomText(
            "Profile",
            fontSize: 25,
          ),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                AuthController().logout();
              },
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/128/1828/1828479.png',
                  width: 25,
                ),
              ),
            ),
            const SizedBox(width: 15)
          ],
        ),
        body: SizedBox(
            width: SizeConfig.w(context),
            child: Consumer<AuthProvider>(
              builder: (context, value, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return openBottomSheet();
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  NetworkImage(value.studentModel!.img),
                            ),
                            const Positioned(
                                top: 88,
                                left: 85,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 236, 236, 236),
                                  radius: 16,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: Color.fromARGB(255, 96, 96, 96),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        '${value.studentModel!.firstName} ${value.studentModel!.lastName}',
                        fontSize: 24,
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        value.studentModel!.email,
                        color: AppColors.kAsh,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            'Joined at ${value.studentModel!.joinedDate.substring(0, 10)}',
                            color: AppColors.kAsh,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              UtilFunctions.navigateTo(
                                  context, const GeneralProfile());
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 12,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            bottomContainer(
                                context,
                                const Color.fromARGB(255, 149, 245, 194)
                                    .withOpacity(.2),
                                const Color.fromARGB(255, 149, 245, 194)
                                    .withOpacity(.4),
                                AssetConstants.learningFilled,
                                const Color(0xff28B887),
                                'Total Courses',
                                '${Provider.of<CourseProvider>(context, listen: false).courses.length} Courses'),
                            StreamBuilder<QuerySnapshot>(
                                stream: EnrollController()
                                    .getEnrollments(value.studentModel!.sid),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const CustomText('No enrolls');
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  }
                                  enrolls.clear();
                                  for (var e in snapshot.data!.docs) {
                                    Map<String, dynamic> data =
                                        e.data() as Map<String, dynamic>;
                                    var model = EnrollModel.fromJson(data);

                                    enrolls.add(model);
                                  }
                                  return bottomContainer(
                                      context,
                                      const Color.fromARGB(255, 240, 245, 149)
                                          .withOpacity(.2),
                                      const Color(0xffFAF3B1),
                                      AssetConstants.learningFilled,
                                      const Color(0xffC2AD21),
                                      'Enrolled',
                                      enrolls.length == 1
                                          ? "${enrolls.length} Course"
                                          : "${enrolls.length} Courses");
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const ContactContainer(),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }

//-----the custom container for bottom two containers
  Container bottomContainer(
    BuildContext context,
    Color bgColor,
    Color iconBgColor,
    String imgPath,
    Color iconColor,
    String textOne,
    String textTwo,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: SizeConfig.w(context) * 0.42,
      height: 140,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: iconBgColor,
                child: Image.asset(
                  imgPath,
                  width: 20,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 10),
              CustomTextHeebo(
                textOne,
                color: const Color.fromARGB(255, 140, 140, 140),
                fontWeight: FontWeight.w400,
                fontSize: 16,
              )
            ],
          ),
          CustomText(
            textTwo,
            fontSize: 20,
          )
        ],
      ),
    );
  }

//----custom container for bottom sheet
  Container openBottomSheet() {
    return Container(
      height: 130,
      width: SizeConfig.w(context) * 0.9,
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .selectAndUploadProfileImageCamera(context);
            },
            child: const Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 231, 61, 132),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 10),
                CustomText('Camera')
              ],
            ),
          ),
          const SizedBox(width: 30),
          InkWell(
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .selectAndUploadProfileImageGallery(context);
            },
            child: const Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 99, 176, 248),
                  child: Icon(
                    Icons.image,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 10),
                CustomText('Gallery')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
