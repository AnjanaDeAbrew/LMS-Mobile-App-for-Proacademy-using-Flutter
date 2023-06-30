import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:proacademy_lms/providers/auth/signup_provider.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:provider/provider.dart';

class CustomMobileTextField extends StatelessWidget {
  const CustomMobileTextField({
    super.key,
    required this.hintTxt,
    required this.controller,
  });
  final String hintTxt;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: hintTxt,
        fillColor: AppColors.white,
        filled: true,
        hintStyle: const TextStyle(
            color: AppColors.kAsh, fontWeight: FontWeight.w400, fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 226, 225, 225)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryBlueColor),
        ),
      ),
      initialCountryCode: 'LK',
      controller: controller,
      onChanged: (value) {
        Provider.of<SignupProvider>(context, listen: false).setMobile =
            value.completeNumber;
      },
      // Provider.of<SignupProvider>(context).mobileController,
    );
  }
}
