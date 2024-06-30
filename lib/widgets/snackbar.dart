import 'package:blissbody_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackBar(
    {required String heading,
    required String message,
    required IconData icon,
    Color? color}) {
  return Get.snackbar(
    heading, message,
    duration: const Duration(seconds: 1),
    margin: EdgeInsets.zero,
    icon: Icon(icon, color: Colors.white),
    backgroundColor: ColorConst.primaryGrey,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    // titleText: Text(heading,
    //     style: const TextStyle(
    //       color: ColorConst.titleColor,
    //       fontWeight: FontWeight.w900,
    //       fontSize: 14,
    //       fontFamily: 'Inter',
    //     )),
    // messageText: Text(message,
    //     style: const TextStyle(
    //       color: Colors.white,
    //       fontSize: 12,
    //       fontWeight: FontWeight.bold,
    //       fontFamily: 'Inter',
    //     )),
  );
}
