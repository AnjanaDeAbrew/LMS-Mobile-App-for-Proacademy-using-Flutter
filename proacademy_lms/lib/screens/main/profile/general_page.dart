import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class GeneralProfile extends StatelessWidget {
  const GeneralProfile({super.key});

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
            onPressed: () {
              UtilFunctions.goBack(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Container(
        width: SizeConfig.w(context),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                const SizedBox(height: 50),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(value.studentModel!.img),
                ),
                const SizedBox(height: 40),
                detailCard(
                    context,
                    'Full Name',
                    '${value.studentModel!.firstName} ${value.studentModel!.lastName}',
                    Icons.person_2,
                    Colors.red),
                const Divider(
                    height: 6, color: Color.fromARGB(255, 235, 235, 235)),
                detailCard(context, 'Email Address', value.studentModel!.email,
                    Icons.email, Colors.orange),
                const Divider(
                    height: 6, color: Color.fromARGB(255, 235, 235, 235)),
                detailCard(context, 'BirthDay', value.studentModel!.birthday,
                    Icons.date_range, Colors.amber),
                const Divider(
                    height: 6, color: Color.fromARGB(255, 235, 235, 235)),
                detailCard(context, 'Age', '${value.studentModel!.age}',
                    Icons.person_3, Colors.green),
                const Divider(
                    height: 6, color: Color.fromARGB(255, 235, 235, 235)),
                detailCard(context, 'Address', value.studentModel!.address,
                    Icons.location_on, Colors.blue),
                const Divider(
                    height: 1, color: Color.fromARGB(255, 235, 235, 235)),
                detailCard(context, 'School / University',
                    value.studentModel!.school, Icons.school, Colors.indigo),
                const Divider(
                    height: 6, color: Color.fromARGB(255, 235, 235, 235)),
                detailCard(context, 'Gender', value.studentModel!.gender,
                    Icons.man_outlined, Colors.purple),
                const Divider(
                    height: 6, color: Color.fromARGB(255, 235, 235, 235)),
                detailCard(context, 'Mobile Number', value.studentModel!.mobile,
                    Icons.phone_android, Colors.pink),
                const Divider(
                    height: 6, color: Color.fromARGB(255, 235, 235, 235)),
                detailCard(
                    context,
                    'Joined Date',
                    value.studentModel!.joinedDate.substring(0, 10),
                    Icons.date_range_outlined,
                    Colors.brown),
              ],
            );
          },
        )),
      ),
    ));
  }

  ListTile detailCard(BuildContext context, String title, String subTitle,
          IconData iconData, Color color) =>
      ListTile(
        leading: Icon(
          iconData,
          color: color,
        ),
        title: CustomText(
          title,
          fontSize: 18,
        ),
        subtitle: CustomText(
          subTitle,
          fontSize: 15,
          color: AppColors.kAsh,
        ),
      );
}
