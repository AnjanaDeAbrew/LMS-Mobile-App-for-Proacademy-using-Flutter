import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    Key? key,
    required this.hintTxt,
    this.isObscure = false,
    required this.controller,
    this.keyboardType,
    this.maxLines,
  }) : super(key: key);

  final String hintTxt;
  final bool isObscure;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintTxt,
        hintStyle: const TextStyle(
            color: AppColors.kAsh, fontWeight: FontWeight.w400, fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 226, 225, 225)),
        ),
        filled: true,
        fillColor: AppColors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryBlueColor),
        ),
      ),
    );
  }
}
