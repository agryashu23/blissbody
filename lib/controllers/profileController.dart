import 'dart:io';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  late SharedPreferences prefs;
  var heightdim = true.obs;
  var weightdim = true.obs;
  var selectedGender = 0.obs;
  var weightType = "kg".obs;
  var heightType = "in".obs;
  var isLoading = false.obs;
  var imageUrl = ''.obs;
  var profileDetails = {}.obs;
  var isOwner = false.obs;
  var weight = ''.obs;
  var height = "".obs;
  var age = "".obs;
  RxList<Uint8List> pickedImage = <Uint8List>[].obs;
  var nameValue = "".obs;

  var favourites = [].obs;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;
      final imageTemp = File(pickedFile.path);
      final imageBytes = await imageTemp.readAsBytes();
      pickedImage.value = [];
      pickedImage.add(imageBytes);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  createProfile() async {
    isLoading.value = true;
    var data = {
      "id": authController.userId.value,
      "name": nameController.text,
      "age": ageController.text,
      "gender": selectedGender.value,
      "image": imageUrl.value
    };
    var response = await postRequestUnAuthenticated(
        endpoint: '/create-profile', data: data);
    if (response["success"]) {
      isLoading.value = false;
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile', "true");
      Get.offAllNamed('/start');
      return {"success": true};
    } else {
      isLoading.value = false;
      showErrorSnackBar(
          heading: 'Error',
          message: "Check your internet connection and try again.",
          icon: Icons.error,
          color: Colors.redAccent);
      return {"success": false};
    }
  }

  Future<void> editProfile() async {
    isLoading.value = true;
    var data = {
      "id": authController.userId.value,
      "name": nameController.text,
      "age": ageController.text,
      "gender": selectedGender.value,
      "image": imageUrl.value,
      "weight": weightController.text,
      "height": heightController.text,
      "weight_type": weightdim.value,
      "height_type": heightdim.value
    };
    var response =
        await postRequestUnAuthenticated(endpoint: '/edit/profile', data: data);
    if (response["success"]) {
      isLoading.value = false;
      await getProfile();
      showErrorSnackBar(
          heading: 'Success',
          message: "Profile updated successfully.",
          icon: Icons.person,
          color: Colors.redAccent);
    } else {
      isLoading.value = false;
      showErrorSnackBar(
          heading: 'Error',
          message: "Error in editing profile. Please try again.",
          icon: Icons.error,
          color: Colors.redAccent);
    }
  }

  Future<void> getProfile() async {
    var data = {
      "id": authController.userId.value,
    };
    isLoading.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/get/profile', data: data);
    if (response["success"]) {
      nameController.text = response['user']['name'] ?? "";
      nameValue.value = response['user']['name'] ?? "";
      heightController.text = response['user']['height'] ?? "";
      height.value = response['user']['height'] ?? "";
      weightController.text = response['user']['weight'] ?? "";
      weight.value = response['user']['weight'] ?? "";
      ageController.text = response['user']['age'] ?? "";
      age.value = response['user']['age'] ?? "";
      imageUrl.value = response['user']['image'] ?? "";
      emailController.text = response['user']['email'] ?? "";
      selectedGender.value = response['user']['gender'] ?? 0;
      heightdim.value = response['user']['height_type'] ?? true;
      weightdim.value = response['user']['weight_type'] ?? true;
      favourites.assignAll(response['user']['favourites'] ?? []);
      isLoading.value = false;
      return;
    } else {
      profileDetails.value = {};
      isLoading.value = false;
      return;
    }
  }

  Future<void> getName() async {
    var data = {
      "id": authController.userId.value,
    };
    isLoading.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/get/name', data: data);
    if (response["success"]) {
      nameValue.value = response['name'];
      isLoading.value = false;
      return;
    } else {
      profileDetails.value = {};
      isLoading.value = false;
      return;
    }
  }

  Future<void> getFavourite() async {
    var data = {
      "id": authController.userId.value,
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/favourites', data: data);
    if (response["success"]) {
      favourites.value = response['favourites'];
      isLoading.value = false;
      return;
    } else {
      profileDetails.value = {};
      isLoading.value = false;
      return;
    }
  }

  double calculateAverage(item) {
    double totalRating = 0;
    for (var review in item) {
      totalRating += double.parse(review['rating']);
    }
    double average = item.isNotEmpty ? totalRating / item.length : 0;
    return average;
  }

  void toggleFavourite(id) async {
    var data = {"id": authController.userId.value, "gym_id": id};
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/toggle/favourite', data: data);
    if (response["success"]) {
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }
}
