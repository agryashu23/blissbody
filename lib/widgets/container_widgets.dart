import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget profileTextField(controller, hintText, type) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    style: const TextStyle(color: ColorConst.titleColor, fontSize: 18),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade200, fontSize: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      filled: true,
      fillColor: Colors.grey.shade200,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    ),
    onChanged: (val) {},
  );
}

Widget editTextField(
    TextEditingController controller, String hintText, TextInputType type) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    style: TextStyle(
        color: authController.isDarkMode.value
            ? Colors.white
            : ColorConst.titleColor,
        fontSize: 18),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      filled: true,
      fillColor: authController.isDarkMode.value
          ? ColorConst.dark
          : Colors.grey.shade200,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    ),
  );
}

Widget labelName(context, text) {
  return Padding(
    padding: const EdgeInsets.only(left: 2),
    child: Text(
      text,
      style: TextStyle(
        color: authController.isDarkMode.value
            ? Colors.white
            : ColorConst.titleColor,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    ),
  );
}

Widget submitBtn(context, text, onTap) {
  return Container(
    width: getW(context) * 0.8,
    height: 55,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorConst.borderColor, width: 0.6)),
    child: TextButton(
      onPressed: onTap,
      child: Text(text,
          style: const TextStyle(
              color: ColorConst.btnColor,
              fontSize: 20,
              fontWeight: FontWeight.w500)),
    ),
  );
}
