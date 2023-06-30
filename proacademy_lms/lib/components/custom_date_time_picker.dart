// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:proacademy_lms/providers/auth/signup_provider.dart';
// import 'package:proacademy_lms/utils/app_colors.dart';
// import 'package:provider/provider.dart';

// class CustomDateTimePicker extends StatefulWidget {
//   const CustomDateTimePicker({
//     super.key,
//     required this.hintTxt,
//     required this.controller,
//   });
//   final String hintTxt;
//   final TextEditingController controller;

//   @override
//   State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
// }

// class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: AppColors.white,
//       ),
//       child: TextField(
//         controller: widget.controller,
//         decoration: InputDecoration(
//           hintText: widget.hintTxt,
//           hintStyle: const TextStyle(
//               color: AppColors.kAsh, fontWeight: FontWeight.w400, fontSize: 15),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:
//                 const BorderSide(color: Color.fromARGB(255, 226, 225, 225)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: AppColors.red),
//           ),
//         ),
//         readOnly: true,
//         onTap: () async {
//           DateTime? pickedDate = await showDatePicker(
//               context: context,
//               initialDate: DateTime(2000),
//               firstDate: DateTime(1988),
//               lastDate: DateTime(2005, 12, 31));

//           if (pickedDate != null) {
//             String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

//             setState(() {
//               widget.controller.text = formattedDate;
//               Provider.of<SignupProvider>(context, listen: false)
//                   .setAge(formattedDate);
//             });
//           } else {
//             print("Date is not selected");
//           }
//         },
//       ),
//     );
//   }
// }
