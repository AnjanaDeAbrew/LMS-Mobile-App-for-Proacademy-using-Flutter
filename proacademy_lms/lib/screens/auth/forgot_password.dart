import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_button.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/custom_textfield.dart';
import 'package:proacademy_lms/providers/auth/login_provider.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetConstants.loginBg), fit: BoxFit.fill)),
        width: SizeConfig.w(context),
        height: SizeConfig.h(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => UtilFunctions.goBack(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: CustomText(
                  "Forgot Password",
                  fontSize: 37,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 58, 83, 166),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: Image.asset(
                AssetConstants.forgot,
                width: 250,
              )),
              const SizedBox(height: 60),
              const CustomText(
                "Please, enter your email address. You will receive\na link to create a new password via email.",
                textAlign: TextAlign.justify,
                fontSize: 16,
                color: Color.fromARGB(255, 159, 159, 159),
              ),
              const SizedBox(height: 40),
              CustomTextfield(
                hintTxt: "Enter Your Email",
                controller: Provider.of<LoginProvider>(context, listen: false)
                    .resetEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 60),
              Center(child: Consumer<LoginProvider>(
                builder: (context, value, child) {
                  return CustomButton(
                    text: "Send Rest Email",
                    isLoading: value.isLoading,
                    onTap: () {
                      value.startSendPasswordResetEmail(context);
                    },
                    radius: 100,
                    width: SizeConfig.w(context) * 0.7,
                  );
                },
              )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }
}
