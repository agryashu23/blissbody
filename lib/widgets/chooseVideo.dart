import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/pages/mainpage.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChooseVideo extends StatelessWidget {
  ChooseVideo({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MainPage(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "PICK REEL",
              style: TextStyle(
                letterSpacing: 1.5,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: null,
            backgroundColor:
                authController.isDarkMode.value ? Colors.black : Colors.white,
            elevation: 0,
          ),
          body: Container(
            color:
                authController.isDarkMode.value ? Colors.black : Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await homeController.pickVideo();
                    },
                    child: Card(
                      elevation: 3,
                      color: authController.isDarkMode.value
                          ? ColorConst.dark
                          : Colors.white,
                      surfaceTintColor: Colors.grey.shade100,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getW(context) * 0.07,
                            vertical: getH(context) * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.video_camera_front,
                              color: authController.isDarkMode.value
                                  ? Colors.white
                                  : ColorConst.titleColor,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Pick Video",
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 0.3,
                                  color: authController.isDarkMode.value
                                      ? Colors.white
                                      : ColorConst.titleColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await homeController.pickImage();
                    },
                    child: Card(
                      elevation: 3,
                      color: authController.isDarkMode.value
                          ? ColorConst.dark
                          : Colors.white,
                      surfaceTintColor: Colors.grey.shade100,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getW(context) * 0.07,
                            vertical: getH(context) * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image,
                              color: authController.isDarkMode.value
                                  ? Colors.white
                                  : ColorConst.titleColor,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Pick image",
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 0.3,
                                  color: authController.isDarkMode.value
                                      ? Colors.white
                                      : ColorConst.titleColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
