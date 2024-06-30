import 'dart:async';

import 'package:blissbody_app/constants/images.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/BHSplashScreen';

  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (authController.userId.value != "" &&
          authController.userId.value != "null" &&
          authController.isAdmin.value) {
        Get.offAllNamed('/admin/home');
      } else if (authController.userId.value != "" &&
          authController.userId.value != "null" &&
          authController.profileC.value == "true") {
        Get.offAllNamed('/start');
      } else if (authController.userId.value != "" &&
          authController.userId.value != "null" &&
          authController.profileC.value != "true") {
        Get.offAllNamed('/create-profile');
      } else {
        Get.offNamed('/onboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(logo,
            height: getH(context) * 0.65, width: getW(context) * 0.65),
      ),
    );
  }
}
