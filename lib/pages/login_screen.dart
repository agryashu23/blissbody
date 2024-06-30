import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/pages/mainpage.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();
  // List<String> tabs = ["Guest", "Gym owner/Trainer"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MainPage(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Container(
                    //   margin: EdgeInsets.only(
                    //     top: getW(context) * 0.05,
                    //   ),
                    //   child: Image.asset('assets/images/login_bg.jpg',
                    //       height: getH(context) * 0.2, width: double.infinity),
                    // ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.2),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: ColorConst.titleColor,
                              fontSize: getF(context, 32.0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.015),
                        child: Text(
                          "Hi, Welcome back you are missed.",
                          style: TextStyle(
                            color: ColorConst.primaryGrey,
                            fontSize: getF(context, 16.0),
                          ),
                        ),
                      ),
                    ),
                    // Obx(
                    //   () => Center(
                    //     child: Container(
                    //         margin: EdgeInsets.only(top: getH(context) * 0.1),
                    //         child: FlutterToggleTab(
                    //           width: getW(context) * 0.25,
                    //           borderRadius: 10,
                    //           height: 40,
                    //           selectedIndex: authController.selectedTab.value,
                    //           selectedBackgroundColors: const [
                    //             ColorConst.websiteHomeBox,
                    //             ColorConst.websiteHomeBox
                    //           ],
                    //           unSelectedBackgroundColors: const [
                    //             ColorConst.primaryGrey
                    //           ],
                    //           selectedTextStyle: const TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.bold),
                    //           unSelectedTextStyle: const TextStyle(
                    //               color: Colors.black87,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w500),
                    //           labels: tabs,
                    //           selectedLabelIndex: (index) {
                    //             authController.selectedTab.value = index;
                    //           },
                    //           isScroll: false,
                    //         )),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: getH(context) * 0.2),
                      child: Text(
                        "Phone no.",
                        style: TextStyle(
                          color: ColorConst.titleColor,
                          fontSize: getF(context, 16.0),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: getH(context) * 0.005),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: TextFormField(
                          controller: authController.phoneController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: ColorConst.primaryGrey, fontSize: 18),
                          decoration: InputDecoration(
                            prefixText: "+91 ",
                            hintText: "Enter your mobile number",
                            hintStyle: const TextStyle(
                                color: ColorConst.primaryGrey, fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 12),
                            prefixStyle: const TextStyle(
                                color: ColorConst.primaryGrey, fontSize: 18),
                          ),
                          onChanged: (val) {
                            authController.phoneNo.value = val;
                            if (val.length == 10) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          validator: (value) {
                            if (authController.phoneNo.value.length == 10) {
                              return null;
                            }
                            return "Enter Valid PhoneNumber";
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(top: getH(context) * 0.05),
                          child: Obx(
                            () => submitBtn(
                                context,
                                authController.isLoading.value
                                    ? "Please Wait..."
                                    : "Sign In", () async {
                              if (authController.phoneNo.value.length != 10) {
                                showErrorSnackBar(
                                    heading: "Error",
                                    message:
                                        "Please enter correct mobile number",
                                    icon: Icons.phone,
                                    color: Colors.white);
                              } else {
                                await authController.sendOtp();
                                //
                              }
                              // Get.toNamed('/otp');
                            }),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
