import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return CustomText(
      text,
      fontSize: 25,
      fontWeight: FontWeight.w600,
    );
  }
}
