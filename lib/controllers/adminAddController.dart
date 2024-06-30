import 'dart:convert';
import 'dart:io';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/globals/globals.dart';
import 'package:blissbody_app/models/image_item.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import "package:http/http.dart" as http;

class AdminAddController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController month1Controller = TextEditingController();
  final TextEditingController month3Controller = TextEditingController();
  final TextEditingController month6Controller = TextEditingController();
  final TextEditingController yearController = TextEditingController();
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
  var cities = [].obs;
  var isLoading = false.obs;
  var hourPackage = [].obs;
  List imageUrls = [].obs;
  var editCity = "".obs;
  var videoUrl = "".obs;
  var isAssetVideo = false.obs;
  var videoSave = "".obs;
  RxList<Map<String, String>> suggestions = RxList<Map<String, String>>();
  var images = <ImageItem>[].obs;

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

  void clearAllGym() {
    nameController.clear();
    locationController.clear();
    cityController.clear();
    openingTime.value = "";
    closingTime.value = "";
    editabout.value = "";
    editAmenities.value = [];
    editMachines.value = [];
    imageUrls = [];
    videoSave.value = "";
    editDays.value = [];
    mSlots.value = ["", ""];
    eSlots.value = ["", ""];
  }

  Future<void> createGym(hours, packages) async {
    isLoading.value = true;
    var data = {
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
    var response =
        await postRequestUnAuthenticated(endpoint: '/create/gym', data: data);
    if (response["success"]) {
      isLoading.value = false;
      clearAllGym();
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

  void removeImage(int index) {
    images.removeAt(index);
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
