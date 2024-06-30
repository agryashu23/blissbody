import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../services/rest.dart';

class DetailController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final HomeController homeController = Get.find<HomeController>();

  var selectedOption = '1 Month'.obs;
  var unselectedDate = false.obs;

  var selectedPrice = "".obs;
  var isLoading = false.obs;
  var selectedDate = "".obs;
  var selectedDay = "".obs;

  var morningSlots = [].obs;
  var eveningSlots = [].obs;

  var gymId = "".obs;
  var booking = [].obs;
  var transaction = [].obs;

  var receive = "".obs;

  var selectedTime = "".obs;

  List<Widget> caraouselWidgets = [];

  List<String> createTimeSlots(String start, String end) {
    final startTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(start.split(":")[0]),
        int.parse(start.split(":")[1]));
    final endTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        int.parse(end.split(":")[0]),
        int.parse(end.split(":")[1]));
    List<String> slots = [];
    var currentTime = startTime;
    while (currentTime.isBefore(endTime)) {
      String formattedTime = DateFormat('hh:mm a').format(currentTime);
      slots.add(formattedTime);
      currentTime = currentTime.add(const Duration(hours: 1));
    }

    return slots;
  }

  Future<void> createBooking(String payment) async {
    var data = {
      "user": authController.userId.value,
      "receive": receive.value,
      "gym": gymId.value,
      "date": selectedDate.value,
      "day": selectedDay.value,
      "time": selectedTime.value,
      "package": selectedOption.value,
      "price": selectedPrice.value,
      "payment_id": payment,
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/create/booking', data: data);
    if (response["success"]) {
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  Future<void> createTransaction(String payment) async {
    var data = {
      "user": authController.userId.value,
      "receive": receive.value,
      "gym": gymId.value,
      "date": selectedDate.value,
      "price": selectedPrice.value,
      "payment_id": payment
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/create/transaction', data: data);
    if (response["success"]) {
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  Future<void> getBooking() async {
    var data = {
      "user": authController.userId.value,
    };
    isLoading.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/get/booking', data: data);
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

  Future<void> getTransaction() async {
    var data = {
      "user": authController.userId.value,
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/transaction', data: data);
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

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showErrorSnackBar(
        heading: "Error",
        message: "Payment failed. Try again",
        icon: Icons.payment);
    // showAlertDialog(context, "Payment Failed",
    //     "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    await createBooking(response.paymentId.toString());
    await createTransaction(response.paymentId.toString());
    showErrorSnackBar(
        heading: "Success",
        message: "Booking successful",
        icon: Icons.book_online);
    await getBooking();
    homeController.scaffoldKey = GlobalKey<ScaffoldState>();
    Get.offAllNamed('/start');
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) async {
    await createBooking(response.walletName.toString() + selectedDate.value);
    await createTransaction(
        response.walletName.toString() + selectedDate.value);
    showErrorSnackBar(
        heading: "Success",
        message: "Booking successful",
        icon: Icons.book_online);
    Get.offAllNamed('/start');
    // showAlertDialog(
    //     context, "External Wallet Selected", "${response.walletName}");
  }
}
