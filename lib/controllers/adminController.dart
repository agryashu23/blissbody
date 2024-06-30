import 'dart:convert';
import 'dart:io';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/globals/globals.dart';
import 'package:blissbody_app/models/image_item.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class AdminController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController month1Controller = TextEditingController();
  final TextEditingController month3Controller = TextEditingController();
  final TextEditingController month6Controller = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  var editabout = "".obs;
  var openingTime = "".obs;
  var closingTime = "".obs;
  var selectedGender = 0.obs;
  var mSlots = <String>["", ""].obs;
  var eSlots = <String>["", ""].obs;
  var editAmenities = [].obs;
  var editMachines = [].obs;
  var editReviews = [].obs;
  var editDays = [].obs;
  var hourPackage = [].obs;
  List imageUrls = [].obs;
  var editCity = "".obs;
  var videoUrl = "".obs;
  var isAssetVideo = false.obs;
  var videoSave = "".obs;
  RxList<Map<String, String>> suggestions = RxList<Map<String, String>>();
  var images = <ImageItem>[].obs;

  var usersLength = 0.obs;
  var gymsLength = 0.obs;
  var reelsLength = 0.obs;
  var bookingsLength = 0.obs;
  var isLoading = false.obs;
  var totalPrice = 0.obs;
  var bookings = [].obs;
  var cities = [].obs;
  var currentCity = "Varanasi".obs;

  var transactions = [].obs;

  var gyms = [].obs;
  var owngyms = [].obs;

  var imageNetworks = [].obs;

  final TextEditingController searchCityController = TextEditingController();

  List initialCities = [
    'Varanasi',
    "Mumbai",
    "Bangalore",
    "Kolkata",
    "Delhi",
    "Ahmedabad",
    "Chandigarh"
  ];
  bool allCheck() {
    if (nameController.text.isEmpty ||
        locationController.text.isEmpty ||
        cityController.text.isEmpty ||
        openingTime.isEmpty ||
        closingTime.isEmpty ||
        editabout.isEmpty ||
        editAmenities.isEmpty ||
        editMachines.isEmpty ||
        editDays.isEmpty) {
      return false;
    }
    return true;
  }

  void removeImage(int index) {
    images.removeAt(index);
  }

  void getUsersLength() async {
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/users/length', data: {});
    if (response["success"]) {
      usersLength.value = response['user'];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  void getGymsLength() async {
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/gyms/length', data: {});
    if (response["success"]) {
      gymsLength.value = response['gym'];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  void getReelsLength() async {
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/reels/length', data: {});
    if (response["success"]) {
      reelsLength.value = response['reels'];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  Future<void> editGym(hours, packages, id) async {
    isLoading.value = true;
    var data = {
      "id": id,
      "user": authController.userId.value,
      "name": nameController.text,
      "address": locationController.text,
      "city": cityController.text,
      "link": linkController.text,
      "phone": contactController.text,
      "opening_time": openingTime.value,
      "closing_time": closingTime.value,
      "gender": selectedGender.value,
      "about": editabout.value,
      "amenities": editAmenities,
      "machines": editMachines,
      "images": imageUrls,
      "video": videoSave.value,
      "hour_package": hours,
      "packages": packages,
      "days": editDays,
      "morning_time": mSlots,
      "evening_time": eSlots,
      "active": true,
    };
    var response = await postRequestUnAuthenticated(
        endpoint: '/edit/admin/gyms', data: data);
    if (response["success"]) {
      isLoading.value = false;
      showErrorSnackBar(
          heading: "Success",
          message: "Gym profile updated.",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    } else {
      isLoading.value = false;
      showErrorSnackBar(
          heading: "Error",
          message: "Error in updating profile.",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    }
  }

  void getBookingsLength() async {
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/bookings/length', data: {});
    if (response["success"]) {
      bookingsLength.value = response['booking'];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  void getTotalPrice() async {
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/total/price', data: {});
    if (response["success"]) {
      totalPrice.value = response['totalPrice'];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  void getBookings() async {
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/admin/bookings', data: {});
    if (response["success"]) {
      bookings.value = response['bookings'];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  void getTransactions() async {
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/admin/transactions', data: {});
    if (response["success"]) {
      transactions.value = response['transactions'];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  Future<void> getAdminGyms() async {
    isLoading.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/get/all/gyms', data: {});
    if (response["success"]) {
      gyms.value = response['gym'];
      isLoading.value = false;
      return;
    } else {
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

  Future<void> getAdminOwnGyms() async {
    isLoading.value = true;
    var data = {"user": authController.userId.value};
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/admin/gyms', data: data);
    if (response["success"]) {
      owngyms.value = response['gym'];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  void fetchSuggestions(String input) async {
    if (input.isEmpty) {
      cities.value = initialCities;
      return;
    }
    final uri = '$hostUrl/api/searchCity?input=$input';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      cities.value = List<String>.from(data['cities']);
      return;
    } else {
      cities.value = initialCities;
      throw Exception('Failed to load address');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;

      final imageTemp = File(pickedFile.path);
      final Uint8List imageBytes = await imageTemp.readAsBytes();

      final ImageItem newImageItem = ImageItem(
        imageUrl: '',
        imageData: imageBytes,
        isNetworkImage: false,
      );
      images.add(newImageItem);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
    }
  }

  Future<void> pickVideo(ImageSource source) async {
    try {
      XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (video != null) {
        videoUrl.value = '';
        var file = File(video.path);
        final info = await VideoCompress.compressVideo(
          file.path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
          startTime: 0,
          duration: 2,
          includeAudio: true,
        );
        videoUrl.value = info!.path!;
        isAssetVideo.value = true;
      }
    } on PlatformException catch (e) {
      print('Failed to pick video: $e');
    }
  }
}
