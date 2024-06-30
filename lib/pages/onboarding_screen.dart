import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/constants/images.dart';
import 'package:blissbody_app/constants/text.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/onboardController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/pages/mainpage.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnboardController onboardController = Get.find<OnboardController>();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.primaryBackground,
      body: MainPage(
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (i) {
                onboardController.currentPage.value = i;
              },
              children: [
                Column(
                  children: <Widget>[
                    commonCacheImageWidget(onboard1Image, getH(context) * 0.7,
                        width: getW(context), fit: BoxFit.cover),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      onboardText1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorConst.titleColor),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(onboardSubtitle1,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ColorConst.primaryGrey)),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    commonCacheImageWidget(onboard2Image, getH(context) * 0.7,
                        width: getW(context), fit: BoxFit.cover),
                    const SizedBox(height: 16),
                    const Text(
                      onboardText2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorConst.titleColor),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(onboardSubtitle2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ColorConst.primaryGrey)),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    commonCacheImageWidget(onboard3Image, getH(context) * 0.7,
                        width: getW(context), fit: BoxFit.cover),
                    const SizedBox(height: 16),
                    const Text(
                      onboardText3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorConst.titleColor),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(onboardSubtitle3,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ColorConst.primaryGrey)),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 90,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Obx(
                  () => DotsIndicator(
                    dotsCount: 3,
                    position: onboardController.currentPage.value,
                    decorator: DotsDecorator(
                      color: ColorConst.primaryGrey.withOpacity(0.5),
                      activeColor: ColorConst.websiteHomeBox,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Obx(
                () => Visibility(
                  visible: onboardController.currentPage.value != 2,
                  replacement: Container(
                    margin: const EdgeInsets.only(),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: submitBtn(context, "Get Started", () {
                          Get.offAllNamed('/login');
                        })),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text('Skip',
                            style: TextStyle(
                                color: ColorConst.primaryGrey, fontSize: 15)),
                        onPressed: () {
                          onboardController.currentPage.value = 2;
                          // BHLoginScreen().launch(context);
                        },
                      ),
                      TextButton(
                        child: const Text("Next",
                            style: TextStyle(
                                color: ColorConst.titleColor, fontSize: 15)),
                        onPressed: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
