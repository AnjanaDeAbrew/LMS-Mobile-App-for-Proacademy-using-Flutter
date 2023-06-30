import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.textAlign,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
    this.color,
    this.textOverflow,
    this.maxLines,
  }) : super(key: key);

  final String text;
  final TextAlign? textAlign;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? textOverflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: 0),
      overflow: textOverflow,
    );
  }
}
