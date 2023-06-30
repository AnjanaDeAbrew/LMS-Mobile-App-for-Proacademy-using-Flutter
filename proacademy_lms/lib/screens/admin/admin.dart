import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_button.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/components/custom_textfield.dart';
import 'package:proacademy_lms/providers/course/course_provider.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetConstants.loginBg), fit: BoxFit.fill)),
        width: SizeConfig.w(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => UtilFunctions.goBack(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              const Center(
                child: CustomText(
                  "Admin",
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 58, 83, 166),
                ),
              ),
              const SizedBox(height: 25),
              Center(child: Consumer<CourseProvider>(
                builder: (context, value, child) {
                  return value.image.path == ""
                      ? IconButton(
                          onPressed: () => value.selectImage(),
                          icon: const Icon(
                            Icons.image,
                            size: 60,
                          ),
                        )
                      : InkWell(
                          onTap: () => value.selectImage(),
                          child: Image.file(
                            value.image,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        );
                },
              )),
              const SizedBox(height: 25),
              CustomTextfield(
                  hintTxt: "Enter Course name",
                  controller: Provider.of<CourseProvider>(context)
                      .courseNameController),
              const SizedBox(height: 20),
              CustomTextfield(
                hintTxt: "Enter language Name",
                controller:
                    Provider.of<CourseProvider>(context).langNameController,
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                hintTxt: "Enter description",
                maxLines: 8,
                controller:
                    Provider.of<CourseProvider>(context).descriptionController,
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                hintTxt: "Enter Price",
                keyboardType: TextInputType.number,
                controller:
                    Provider.of<CourseProvider>(context).priceController,
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                hintTxt: "Enter Sessions",
                keyboardType: TextInputType.number,
                controller:
                    Provider.of<CourseProvider>(context).sessionController,
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                hintTxt: "Enter duration",
                keyboardType: TextInputType.number,
                controller:
                    Provider.of<CourseProvider>(context).durationController,
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                hintTxt: "Enter link",
                controller: Provider.of<CourseProvider>(context).linkController,
              ),
              const SizedBox(height: 60),
              Center(
                child: CustomButton(
                  text: "add",
                  onTap: () {
                    Provider.of<CourseProvider>(context, listen: false)
                        .startSaveProductData();
                  },
                  radius: 100,
                  width: SizeConfig.w(context) * 0.7,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ));
  }
}
