import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final AuthController authController = Get.find<AuthController>();

Widget packageCard(context, TextEditingController controller, String title) {
  return Obx(
    () => Card(
      surfaceTintColor:
          authController.isDarkMode.value ? Colors.grey.shade100 : Colors.white,
      color: authController.isDarkMode.value ? ColorConst.dark : Colors.white,
      margin: EdgeInsets.symmetric(
          horizontal: getW(context) * 0.03, vertical: getH(context) * 0.01),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: authController.isDarkMode.value
                ? ColorConst.dark
                : ColorConst.titleColor,
            width: 0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getH(context) * 0.025, horizontal: getW(context) * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.timelapse,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
            ),
            SizedBox(
              width: getW(context) * 0.02,
            ),
            Text(
              title,
              style: TextStyle(
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
              ),
            ),
            const Spacer(),
            SizedBox(
                width: getW(context) * 0.25,
                height: getH(context) * 0.05,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: authController.isDarkMode.value
                            ? Colors.white
                            : ColorConst.titleColor,
                        fontSize: 15),
                    decoration: InputDecoration(
                      hintText: "Price",
                      prefixText: "₹",
                      prefixStyle:
                          const TextStyle(color: ColorConst.titleColor),
                      hintStyle:
                          TextStyle(color: Colors.grey.shade200, fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: authController.isDarkMode.value
                          ? ColorConst.dark
                          : Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                    ),
                    // onChanged: (val) {
                    //   ownerHomeController.packages[index]['price'].value = val;
                    // },
                  ),
                )),
            SizedBox(
              width: getW(context) * 0.04,
            ),
            Container(
              width: getW(context) * 0.2,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: ColorConst.borderColor, width: 0.6)),
              child: TextButton(
                onPressed: () {
                  controller.text = "";
                },
                child: const Text("Reset",
                    style: TextStyle(
                        color: ColorConst.btnColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            // SizedBox(
            //   width: getW(context) * 0.02,
            // ),
            // Container(
            //   width: getW(context) * 0.1,
            //   height: 55,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(color: ColorConst.borderColor, width: 0.6)),
            //   child: TextButton(
            //     onPressed: () {},
            //     child: const Text("Save",
            //         style: TextStyle(
            //             color: ColorConst.btnColor,
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500)),
            //   ),
            // )
          ],
        ),
      ),
    ),
  );
}
