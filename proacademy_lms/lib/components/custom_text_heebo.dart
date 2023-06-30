import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextHeebo extends StatelessWidget {
  const CustomTextHeebo(
    this.text, {
    Key? key,
    this.textAlign,
    this.fontSize = 15,
    this.fontWeight,
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
      style: GoogleFonts.heebo(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: textOverflow,
    );
  }
}
