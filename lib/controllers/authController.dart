import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  var phoneNo = "".obs;

  var profileC = "".obs;

  var isDarkMode = false.obs;

  late SharedPreferences prefs;

  var isAdmin = false.obs;

  @override
  void onInit() async {
    super.onInit();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('userId');
    userId.value = action.toString();
    final String? phone = prefs.getString('phone');
    phoneNo.value = phone.toString();
    final String? profile = prefs.getString('profile');
    profileC.value = profile.toString();
    isAdmin.value = prefs.getBool('admin') ?? false;
  }

  Future<void> logout() async {
    prefs = await SharedPreferences.getInstance();
    phoneNo.value = "";
    phoneController.clear();
    otpCode.value = "";
    otpNew.value = "";
    await prefs.remove('userId');
    await prefs.remove('phone');
    await prefs.remove('profile');
    await prefs.remove('admin');
  }

  var selectedTab = 0.obs;
  var otpCode = "".obs;
  var isLoading = false.obs;
  var otpNew = "".obs;
  var isLogged = false.obs;
  var userId = "".obs;

  sendOtp() async {
    isLoading.value = true;
    var data = {
      'phone': phoneNo.value,
    };
    var response =
        await postRequestUnAuthenticated(endpoint: '/send-otp', data: data);
    if (response["success"]) {
      isLoading.value = false;
      otpNew.value = response['otp'];
      Get.toNamed('/otp');
      return {"success": true};
    } else {
      isLoading.value = false;
      showErrorSnackBar(
          heading: 'Error',
          message: "Check internet connection and try again.",
          icon: Icons.error,
          color: Colors.redAccent);
      return {"success": false};
    }
  }

  verifyOtp() async {
    isLoading.value = true;
    var data = {'phone': "91${phoneNo.value}"};
    var response =
        await postRequestUnAuthenticated(endpoint: '/verify-otp', data: data);
    if (response["success"]) {
      isLoading.value = false;
      userId.value = response['user']['_id'];
      isLogged.value = response['logged'];
      await prefs.setString('userId', userId.value);
      await prefs.setString('phone', phoneController.text);
      if (isLogged.value) {
        await prefs.setString("profile", "true");
      }
      return {"success": true};
    } else {
      isLoading.value = false;

      return {"success": false};
    }
  }
}
