import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_lms/components/custom_button.dart';
import 'package:proacademy_lms/components/custom_password_textfield.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/custom_textfield.dart';
import 'package:proacademy_lms/providers/auth/login_provider.dart';
import 'package:proacademy_lms/screens/auth/forgot_password.dart';
import 'package:proacademy_lms/screens/auth/signup_page.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    "Login",
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 58, 83, 166),
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: Image.asset(AssetConstants.login)),
                const SizedBox(height: 20),
                CustomTextfield(
                  hintTxt: "Enter Your Email",
                  controller: Provider.of<LoginProvider>(context, listen: false)
                      .emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomPasswordTextField(
                  hintTxt: "Enter Your Password",
                  controller: Provider.of<LoginProvider>(context, listen: false)
                      .passwordController,
                  iconOne: Icons.visibility_off,
                  iconTwo: Icons.visibility,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => UtilFunctions.navigateTo(
                        context, ZoomIn(child: const ForgotPasswordPage())),
                    child: const CustomText(
                      "Forgot password?",
                      fontSize: 14,
                      color: AppColors.kAsh,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Consumer<LoginProvider>(
                    builder: (context, value, child) {
                      return CustomButton(
                        text: "Login",
                        isLoading: value.isLoading,
                        onTap: () {
                          value.startSignIn(context);
                        },
                        radius: 100,
                        width: SizeConfig.w(context) * 0.7,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    UtilFunctions.navigateTo(
                        context, FadeInDown(child: const SignupPage()));
                  },
                  child: Center(
                      child: RichText(
                    text: TextSpan(
                      text: "Don't have an account?",
                      style: GoogleFonts.poppins(
                        color: AppColors.kAsh,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      /*defining default style is optional */
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Register',
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryBlueColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
