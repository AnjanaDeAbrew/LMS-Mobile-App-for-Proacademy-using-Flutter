import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_lms/components/custom_text.dart';
import 'package:proacademy_lms/providers/auth/auth_provider.dart';
import 'package:proacademy_lms/providers/notification/notification_provider.dart';
import 'package:proacademy_lms/screens/main/conversations/conversations.dart';
import 'package:proacademy_lms/screens/main/home/home_page.dart';
import 'package:proacademy_lms/screens/main/my_courses/my_courses.dart';
import 'package:proacademy_lms/screens/main/profile/profile_page.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //---since using the observer anything that is observering must be initialize in init state function
    WidgetsBinding.instance.addObserver(this);

    //----get and update the dvice token
    Provider.of<NotificationProvider>(context, listen: false)
        .initNotification(context);

    //----handling foreground notifications
    Provider.of<NotificationProvider>(context, listen: false)
        .foreGroundHandler();

    //----handling when clicked on notifications to open the app from background notifications
    Provider.of<NotificationProvider>(context, listen: false)
        .onClickedOpenedApp(context);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        Provider.of<AuthProvider>(context, listen: false)
            .updateOnlineStates(true, context);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        Provider.of<AuthProvider>(context, listen: false)
            .updateOnlineStates(false, context);
        break;
    }

    Logger().w(state);
  }

  //------list to store bottom navigation screens
  final List<Widget> _screens = [
    const HomePage(),
    const MyCoursesPage(),
    const Conversations(),
    const ProfilePage(),
  ];

  //--------store the active index
  int activeIndex = 0;

  //-----ontap function
  void onItemTapped(int i) {
    setState(() {
      activeIndex = i;
    });
  }

  DateTime backPressedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _onBackButtonDoubleClicked(context),
        child: Scaffold(
          body: _screens[activeIndex],
          bottomNavigationBar: Container(
            height: 85,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 1),
                    color: Color.fromARGB(255, 229, 229, 229),
                    blurRadius: 10),
              ],
              color: Colors.white,
              // border: Border(
              //   top: BorderSide(width: 1.0, color: Colors.lightBlue.shade600),
              // ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                navigationIconAndText(
                    index: 0,
                    imgOne: AssetConstants.homeOutlined,
                    imgTwo: AssetConstants.homeFilled,
                    text: "Home",
                    width: 24),
                navigationIconAndText(
                    index: 1,
                    imgOne: AssetConstants.learningOutlined,
                    imgTwo: AssetConstants.learningFilled,
                    text: "My Courses",
                    width: 30),
                navigationIconAndText(
                    index: 2,
                    imgOne: AssetConstants.chatOutlined,
                    imgTwo: AssetConstants.chatFilled,
                    text: "Chat",
                    width: 26),
                navigationIconAndText(
                    index: 3,
                    imgOne: AssetConstants.avatarOutlined,
                    imgTwo: AssetConstants.avatarFilled,
                    text: "Profile",
                    width: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //--------custom container navigation bar item
  InkWell navigationIconAndText(
      {required int index,
      required String imgOne,
      required String imgTwo,
      required double width,
      required String text}) {
    return InkWell(
      onTap: () => onItemTapped(index),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            activeIndex == index ? imgTwo : imgOne,
            color: activeIndex == index
                ? const Color.fromARGB(255, 47, 75, 201)
                : const Color.fromARGB(255, 161, 160, 160),
            width: width,
          ),
          const SizedBox(height: 5),
          CustomText(
            text,
            fontSize: 13,
            color: activeIndex == index
                ? const Color.fromARGB(255, 47, 75, 201)
                : const Color.fromARGB(255, 161, 160, 160),
          )
        ],
      ),
    );
  }

  void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: CustomText(
          text,
          fontSize: 12,
        ),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        margin: const EdgeInsets.symmetric(horizontal: 100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<bool> _onBackButtonDoubleClicked(BuildContext context) async {
    final difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();
    if (difference >= const Duration(seconds: 2)) {
      toast(context, "Double tap to exit");
      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
}
