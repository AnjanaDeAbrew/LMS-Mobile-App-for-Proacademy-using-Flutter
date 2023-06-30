import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/custom_text_heebo.dart';
import 'package:proacademy_lms/models/objects.dart';
import 'package:proacademy_lms/providers/course/course_provider.dart';
import 'package:proacademy_lms/screens/main/courses_details/course_details_page.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    final List<CourseModel> courses =
        Provider.of<CourseProvider>(context, listen: false).courses;
    return InkWell(
      onTap: () {
        showSearch(
          context: context,
          delegate: MySearchDelegate(searchReults: courses),
        );
      },
      child: Container(
        width: SizeConfig.w(context),
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 249, 249, 249),
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Row(
          children: [
            CustomTextHeebo(
              'Search course',
              fontSize: 17,
              color: Color.fromARGB(255, 182, 182, 182),
              fontWeight: FontWeight.w400,
            ),
            Spacer(),
            Icon(
              Icons.search,
              size: 26,
              color: Color.fromARGB(255, 182, 182, 182),
            )
          ],
        ),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  MySearchDelegate({required this.searchReults});
  List<CourseModel> searchReults;
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear)),
      ];

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CourseModel> suggetions = searchReults.where((searchResult) {
      final result = searchResult.courseName.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        final suggestion = suggetions[index];
        if (query.isNotEmpty) {
          return ListTile(
            leading: Image.network(
              suggestion.img,
              width: 60,
            ),
            contentPadding: const EdgeInsets.all(5),
            title: CustomText(
              suggestion.courseName,
              fontSize: 16,
              color: AppColors.kAsh,
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Provider.of<CourseProvider>(context, listen: false).setCourse =
                  suggestion;
              UtilFunctions.navigateTo(context, const CourseDetailsPage());
            },
          );
        }
        return null;
      },
      itemCount: suggetions.length,
    );
  }
}
