import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerDetailController extends GetxController {
  var images = [].obs;
  var videos = "".obs;

  var isLoading = false.obs;
  // var gymProfile = {}.obs;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  var booking = [].obs;
  var transaction = [].obs;

  final AuthController authController = Get.find<AuthController>();

  IconData getIconByName(String name) {
    if (name == "") {
      return Icons.add;
    }
    return amenityIcons[name] ?? Icons.error;
  }

  Future<void> getOwnerBooking() async {
    var data = {
      "receive": authController.userId.value,
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/owner/booking', data: data);
    if (response["success"]) {
      booking.value = response['booking'];
      isLoading.value = false;
      return;
    } else {
      booking.value = [];
      isLoading.value = false;
      return;
    }
  }

  Future<void> getOwnerTransaction() async {
    var data = {
      "receive": authController.userId.value,
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/owner/transaction', data: data);

    print(response);
    if (response["success"]) {
      transaction.value = response['transaction'];
      isLoading.value = false;
      return;
    } else {
      transaction.value = [];
      isLoading.value = false;
      return;
    }
  }
}
