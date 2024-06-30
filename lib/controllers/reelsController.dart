import 'dart:io';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReelsController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final HomeController homeController = Get.find<HomeController>();
  final ProfileController profileController = Get.find<ProfileController>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   reelsController.getReels();
  // }

  var startValue = 0.0.obs;
  var endValue = 0.0.obs;
  final Rx<XFile?> pickedFile = Rx<XFile?>(null);
  var isPlaying = false.obs;
  var progressVisibility = false.obs;
  var isPicked = false.obs;
  var isLoading = false.obs;

  var outputUrl = "".obs;

  var videoUrl = "".obs;

  var reels = [].obs;
  var userReels = [].obs;
  var isLoadingValue = false.obs;
  var imageReel = "".obs;

  Future<void> saveReel() async {
    var data = {
      "user": authController.userId.value,
      "url": videoUrl.value,
      "name": profileController.nameValue.value,
      "image": profileController.imageUrl.value,
      "type": homeController.fileType.value
    };
    isLoadingValue.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/create/reel', data: data);
    if (response["success"]) {
      isLoadingValue.value = false;
      await getReels();
      showErrorSnackBar(
          heading: "Success",
          message: "Reel created.",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    } else {
      isLoadingValue.value = false;
      showErrorSnackBar(
          heading: "Error",
          message: "Error in creating reel.",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    }
  }

  Future<void> getReels() async {
    isLoading.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/get/reels', data: {});

    if (response["success"]) {
      reels.value = response['reels'];
    } else {
      isLoading.value = false;
      reels.value = [];
      return;
    }
  }

  Future<void> getUserReel() async {
    isLoading.value = true;
    var data = {"id": authController.userId.value};
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/user/reel', data: data);
    if (response["success"]) {
      isLoading.value = false;
      userReels.value = response['reel'];
      // // print(userReels.value);
    } else {
      isLoading.value = false;
      userReels.value = [];
      return;
    }
  }
}
