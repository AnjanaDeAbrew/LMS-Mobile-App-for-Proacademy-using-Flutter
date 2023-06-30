import 'package:flutter/material.dart';
import 'package:proacademy_lms/providers/course/course_provider.dart';
import 'package:proacademy_lms/screens/main/home/widgets/all_cou_tile.dart';
import 'package:provider/provider.dart';

class AllCourseList extends StatelessWidget {
  const AllCourseList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, value, child) {
        return ListView.separated(
            itemBuilder: (context, index) =>
                AllCourseTile(courseModel: value.courses[index]),
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            scrollDirection: Axis.horizontal,
            itemCount: value.courses.length);
      },
    );
  }
}
