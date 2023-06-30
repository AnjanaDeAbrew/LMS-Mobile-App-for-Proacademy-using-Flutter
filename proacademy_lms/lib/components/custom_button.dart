import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.isLoading = false,
      this.color = AppColors.primaryBlueColor,
      this.textColor = AppColors.white,
      this.width = 259,
      this.height = 50,
      this.fontSize = 18,
      this.radius = 8,
      this.fontWeight = FontWeight.w600})
      : super(key: key);

  final String text;
  final Function() onTap;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: isLoading
              ? const SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 40.0,
                )
              : CustomText(
                  text,
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
        ),
      ),
    );
  }
}
