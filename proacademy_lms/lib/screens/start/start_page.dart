import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_button.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/screens/auth/login_page.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeConfig.w(context),
          height: SizeConfig.h(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AssetConstants.startImg,
                width: SizeConfig.w(context),
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  "Explore Your New Skill \nToday and Learn !",
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  "Professional opportunities to explore new things \nyou want to learn new skills",
                  fontSize: 15,
                  textAlign: TextAlign.start,
                  color: AppColors.kAsh,
                ),
              ),
              const Spacer(),
              Center(
                child: CustomButton(
                  text: "Get Started",
                  color: const Color.fromARGB(255, 42, 70, 162),
                  radius: 50,
                  width: SizeConfig.w(context) * 0.8,
                  onTap: () {
                    UtilFunctions.navigateTo(context, const LoginPage());
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
