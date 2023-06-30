import 'package:flutter/material.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactContainer extends StatelessWidget {
  const ContactContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: SizeConfig.w(context) * 0.84 + 10,
      height: 200,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 202, 197).withOpacity(.5),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      const Color.fromARGB(255, 244, 168, 161).withOpacity(.5),
                  child: const Icon(
                    Icons.emergency,
                    color: Color.fromARGB(255, 246, 135, 125),
                    size: 20,
                  )),
              const SizedBox(width: 10),
              const CustomText(
                "Contacts",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Color.fromARGB(255, 140, 140, 140),
              ),
              const SizedBox(width: 10),
              const CustomText(
                "Sudesh Fernando",
                fontSize: 14,
                color: Color.fromARGB(255, 140, 140, 140),
              ),
              const SizedBox(width: 40),
              const Icon(
                Icons.phone,
                size: 20,
                color: Color.fromARGB(255, 140, 140, 140),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse(
                    'tel:0775665656',
                  ));
                },
                child: const CustomText(
                  "0775665656",
                  fontSize: 13,
                  color: AppColors.primaryBlueColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Color.fromARGB(255, 140, 140, 140),
              ),
              const SizedBox(width: 10),
              const CustomText(
                "Janith Malinga",
                fontSize: 14,
                color: Color.fromARGB(255, 140, 140, 140),
              ),
              const SizedBox(width: 59),
              const Icon(
                Icons.phone,
                size: 20,
                color: Color.fromARGB(255, 140, 140, 140),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse(
                    'tel:0778898787',
                  ));
                },
                child: const CustomText(
                  "0778898787",
                  fontSize: 13,
                  color: AppColors.primaryBlueColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
