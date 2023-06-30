import 'package:flutter/material.dart';
import 'package:proacademy_lms/utils/app_colors.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    required this.controller,
    required this.hintTxt,
    this.keyboardType,
    this.iconOne,
    this.iconTwo,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintTxt;

  final IconData? iconOne;
  final IconData? iconTwo;

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _pwVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !_pwVisible,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _pwVisible = !_pwVisible;
              });
            },
            icon: _pwVisible ? Icon(widget.iconOne) : Icon(widget.iconTwo)),
        hintText: widget.hintTxt,
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
