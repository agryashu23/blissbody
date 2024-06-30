import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/globals/globals.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/pages/mainpage.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthController authController = Get.find<AuthController>();
  final FocusNode _pinFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(
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
                      "Verify Code",
                      style: TextStyle(
                          color: ColorConst.titleColor,
                          fontSize: getF(context, 32.0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.008),
                    child: Text(
                      "Please enter the code sent to phone no.",
                      style: TextStyle(
                        color: ColorConst.primaryGrey,
                        fontSize: getF(context, 14.0),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Text(
                      "+91 ${authController.phoneNo.value}",
                      style: TextStyle(
                        color: ColorConst.websiteHomeBox,
                        fontSize: getF(context, 14.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getH(context) * 0.07,
                ),

                Obx(
                  () => PinFieldAutoFill(
                    currentCode: authController.otpCode.value,
                    focusNode: _pinFocusNode,
                    cursor: Cursor(
                        color: Colors.white,
                        width: 2,
                        height: 20,
                        enabled: true),
                    decoration: BoxLooseDecoration(
                        strokeWidth: 0.3,
                        textStyle: const TextStyle(
                            color: ColorConst.titleColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        radius: const Radius.circular(12),
                        strokeColorBuilder:
                            const FixedColorBuilder(ColorConst.borderColor),
                        bgColorBuilder:
                            FixedColorBuilder(Colors.grey.shade300)),
                    codeLength: 6,
                    onCodeChanged: (codes) {
                      authController.otpCode.value = codes.toString();
                      if (codes!.length == 6) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    onCodeSubmitted: (val) {
                      authController.otpCode.value = val.toString();
                    },
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {
                    authController.otpCode.value = "";
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: getW(context) * 0.79),
                    child: Text(
                      "Reset",
                      style: TextStyle(
                          color: ColorConst.dividerLine,
                          fontSize: getF(context, 13.0),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.05),
                    child: Text(
                      "Didn't receive OTP?",
                      style: TextStyle(
                          color: ColorConst.dividerLine,
                          fontSize: getF(context, 16.0),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text(
                      "Resend code",
                      style: TextStyle(
                          color: ColorConst.websiteHomeBox,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorConst.websiteHomeBox,
                          fontSize: getF(context, 14.0),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),

                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: getW(context) * 0.2),
                  child: submitBtn(
                      context,
                      authController.isLoading.value
                          ? "Please Wait..."
                          : "Verify", () async {
                    if (authController.otpCode.value ==
                        authController.otpNew.value) {
                      await authController.verifyOtp();
                      showErrorSnackBar(
                          heading: "Success",
                          message: "Otp verification successful",
                          icon: Icons.phone,
                          color: Colors.white);
                      if (authController.phoneNo.value == adminId) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('admin', true);
                        Get.offAllNamed('/admin/home');
                      } else {
                        if (authController.isLogged.value) {
                          Get.offAllNamed('/start');
                        } else {
                          Get.offAllNamed('/create-profile');
                        }
                      }
                    } else {
                      showErrorSnackBar(
                          heading: 'Error',
                          message: "Enter correct otp",
                          icon: Icons.error,
                          color: Colors.redAccent);
                    }
                    // Get.offAllNamed('/create-profile');
                  }),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
