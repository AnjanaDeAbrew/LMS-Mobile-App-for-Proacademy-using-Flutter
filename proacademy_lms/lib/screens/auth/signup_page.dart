import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proacademy_lms/components/custom_button.dart';
import 'package:proacademy_lms/components/custom_mobile_text_field.dart';
import 'package:proacademy_lms/components/custom_password_textfield.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/custom_textfield.dart';
import 'package:proacademy_lms/providers/auth/signup_provider.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;
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
              const Center(
                child: CustomText(
                  "Signup",
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 58, 83, 166),
                ),
              ),
              const SizedBox(height: 25),
              Center(child: Image.asset(AssetConstants.signup)),
              const SizedBox(height: 25),
              CustomTextfield(
                hintTxt: "Enter Your First Name",
                controller: Provider.of<SignupProvider>(context, listen: false)
                    .firstNameController,
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                hintTxt: "Enter Your Last Name",
                controller: Provider.of<SignupProvider>(context, listen: false)
                    .lastNameController,
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                hintTxt: "Enter Your Email",
                controller: Provider.of<SignupProvider>(context, listen: false)
                    .emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomPasswordTextField(
                controller: Provider.of<SignupProvider>(context, listen: false)
                    .passwordController,
                hintTxt: "Enter the Password",
                iconOne: Icons.visibility_off,
                iconTwo: Icons.visibility,
              ),
              const SizedBox(height: 20),
              // CustomDateTimePicker(
              //   controller: Provider.of<SignupProvider>(context, listen: false)
              //       .birthdayController,
              //   hintTxt: "Select your Birthday",
              // ),
              TextField(
                controller: Provider.of<SignupProvider>(context, listen: false)
                    .birthdayController,
                decoration: InputDecoration(
                  hintText: "Select your Birthday",
                  hintStyle: const TextStyle(
                      color: AppColors.kAsh,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                  filled: true,
                  fillColor: AppColors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 226, 225, 225)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: AppColors.primaryBlueColor),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1988),
                      lastDate: DateTime(2005, 12, 31));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    setState(() {
                      Provider.of<SignupProvider>(context, listen: false)
                          .birthdayController
                          .text = formattedDate;
                      Provider.of<SignupProvider>(context, listen: false)
                          .setAge(formattedDate);
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const CustomText(
                    "Age is",
                    fontSize: 15,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 5),
                          color: AppColors.kAsh.withOpacity(.2),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: Center(
                      child: CustomText(
                          '${Provider.of<SignupProvider>(context, listen: false).age}'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              CustomMobileTextField(
                  controller:
                      Provider.of<SignupProvider>(context, listen: false)
                          .mobileController,
                  hintTxt: "Enter your Mobile Number"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 1,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'ONE';
                        id = 1;
                        Provider.of<SignupProvider>(context, listen: false)
                            .setGender('male');
                      });
                    },
                  ),
                  const Row(
                    children: [Icon(Icons.man_outlined), CustomText("Male")],
                  ),
                  const SizedBox(width: 20),
                  Radio(
                    value: 2,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'TWO';
                        id = 2;
                        Provider.of<SignupProvider>(context, listen: false)
                            .setGender('female');
                      });
                    },
                  ),
                  const Row(
                    children: [Icon(Icons.woman), CustomText("Female")],
                  )
                ],
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                  hintTxt: "Enter Your Address",
                  controller:
                      Provider.of<SignupProvider>(context, listen: false)
                          .addressController),
              const SizedBox(height: 20),
              CustomTextfield(
                  hintTxt: "Enter Your School / University",
                  controller:
                      Provider.of<SignupProvider>(context, listen: false)
                          .schoolController),
              const SizedBox(height: 60),
              Center(child: Consumer<SignupProvider>(
                builder: (context, value, child) {
                  return CustomButton(
                    text: "Signup",
                    isLoading: value.isLoading,
                    onTap: () {
                      value.startSignup(context);
                    },
                    radius: 100,
                    width: SizeConfig.w(context) * 0.7,
                  );
                },
              )),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ));
  }
}
