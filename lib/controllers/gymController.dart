import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GymController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  var imageBytesList = [].obs;
  var isLoading = false.obs;

  var gyms = {}.obs;
  List Monday = [].obs;
  List Tuesday = [].obs;
  List Wednesday = [].obs;
  List Thursday = [].obs;
  List Friday = [].obs;
  List Saturday = [].obs;
  List Sunday = [].obs;

  Future<void> getGymDetails(String id) async {
    var data = {
      "id": id,
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/gym/details', data: data);
    if (response["success"]) {
      gyms.value = response["gym"];
      isLoading.value = false;
      return;
    } else {
      gyms.value = {};
      isLoading.value = false;
      return;
    }
  }

  void savePlans() async {
    var data = {
      "user": authController.userId.value,
      "monday": Monday,
      "tuesday": Tuesday,
      "wednesday": Wednesday,
      "thursday": Thursday,
      "friday": Friday,
      "saturday": Saturday,
      "sunday": Sunday,
    };
    isLoading.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/edit/plans', data: data);
    if (response["success"]) {
      showErrorSnackBar(
          heading: "Success",
          message: "Workout plan updated.",
          icon: Icons.fitness_center);
      isLoading.value = false;
      return;
    } else {
      showErrorSnackBar(
          heading: "Error in updating",
          message: "Check you interent connection and try again.",
          icon: Icons.error);
      isLoading.value = false;
      return;
    }
  }

  void getPlans() async {
    var data = {
      "user": authController.userId.value,
    };
    isLoading.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/get/plans', data: data);
    if (response["success"]) {
      isLoading.value = false;
      Monday.assignAll(response['plan']['monday']);
      Tuesday.assignAll(response['plan']['tuesday']);
      Wednesday.assignAll(response['plan']['wednesday']);
      Thursday.assignAll(response['plan']['thursday']);
      Friday.assignAll(response['plan']['friday']);
      Saturday.assignAll(response['plan']['saturday']);
      Sunday.assignAll(response['plan']['sunday']);
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }
}
