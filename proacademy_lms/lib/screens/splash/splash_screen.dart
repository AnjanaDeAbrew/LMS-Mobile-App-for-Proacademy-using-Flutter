import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/utils/app_colors.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/size_config.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Provider.of<AuthProvider>(context, listen: false)
            .initializeUser(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: SizeConfig.w(context),
      height: SizeConfig.h(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Bounce(
            child: Image.asset(
              AssetConstants.logo,
              width: SizeConfig.w(context) - SizeConfig.w(context) * 0.75,
            ),
          ),
          ElasticIn(
              delay: const Duration(milliseconds: 700),
              child: RichText(
                text: const TextSpan(
                  text: 'PRO',
                  style: TextStyle(
                      color: AppColors.primaryGreenColor,
                      fontSize: 40,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500),
                  /*defining default style is optional */
                  children: <TextSpan>[
                    TextSpan(
                        text: 'ACADEMY',
                        style: TextStyle(
                            color: AppColors.primaryBlueColor,
                            fontSize: 40,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
