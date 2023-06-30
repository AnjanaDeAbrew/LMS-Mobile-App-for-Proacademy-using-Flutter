import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/controllers/enroll_controller.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/screens/main/home/widgets/home_enrol_cou_tile.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:provider/provider.dart';

class EnrollList extends StatelessWidget {
  const EnrollList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //-list for enrollments
    final List<EnrollModel> enrollments = [];
    //---Student model
    StudentModel studentModel =
        Provider.of<AuthProvider>(context, listen: false).studentModel!;

    return StreamBuilder<QuerySnapshot>(
        stream: EnrollController().getEnrollments(
          studentModel.sid,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: CustomText(
                "No messages, error occured",
                fontSize: 20,
                color: AppColors.ashBorder,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          // Logger().wtf(snapshot.data!.docs.length);
          enrollments.clear();

          for (var e in snapshot.data!.docs) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            var model = EnrollModel.fromJson(data);

            enrollments.add(model);
          }
          return enrollments.isEmpty
              ? Column(
                  children: [
                    Image.asset(
                      AssetConstants.noData,
                      width: 150,
                      opacity: const AlwaysStoppedAnimation(.4),
                    ),
                    const CustomText(
                      "Oops! No Enrollments Yet",
                      fontSize: 20,
                      color: Color.fromARGB(255, 203, 203, 203),
                    )
                  ],
                )
              : ListView.separated(
                  itemBuilder: (context, index) =>
                      EnrollTile(model: enrollments[index], index: index),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: enrollments.length);
        });
  }
}
