import 'dart:convert';
import 'dart:io';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/globals/globals.dart';
import 'package:blissbody_app/models/image_item.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:blissbody_app/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class OwnerHomeController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  // final TextEditingController aboutController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController month1Controller = TextEditingController();
  final TextEditingController month3Controller = TextEditingController();
  final TextEditingController month6Controller = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  final TextEditingController linkController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  RxList<Map<String, String>> suggestions = RxList<Map<String, String>>();

  final AuthController authController = Get.find<AuthController>();
  TextEditingController reviewController = TextEditingController();

  var gymId = "".obs;

// edit data
  // var editName = "".obs;
  // var editage = "".obs;
  // var editemail = "".obs;
  // var editlocation = "".obs;
  var editabout = "".obs;
  // var location = "".obs;
  var openingTime = "".obs;
  var closingTime = "".obs;
  var selectedGender = 0.obs;
  var mSlots = <String>["", ""].obs;
  var eSlots = <String>["", ""].obs;
  var editAmenities = [].obs;
  var editMachines = [].obs;
  var editReviews = [].obs;
  var editDays = [].obs;

  var editCity = "".obs;
  var cities = [].obs;
  var isLoading = false.obs;
  var isLoadingSwitch = false.obs;
  var hourPackage = [].obs;
  List imageUrls = [].obs;
  var videoUrl = "".obs;
  var isAssetVideo = false.obs;
  var videoSave = "".obs;
  var avgRating = 0.0.obs;
  var starRatings = {}.obs;
  var images = <ImageItem>[].obs;
  RxList<Uint8List> imageBytesList = <Uint8List>[].obs;
  var isActive = false.obs;

  var imageNetworks = [].obs;
  var reviewsLength = "0".obs;

  var rating = 1.0.obs;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  List<Widget> caraouselWidgets = <Widget>[].obs;

  buildChildrenWidgets() {
    List<Widget> list = [];
    if (imageNetworks.isNotEmpty) {
      list.addAll(imageNetworks.map((url) => Image.network(
            url,
            width: double.infinity,
            fit: BoxFit.cover,
          )));
    }

    if (videoUrl.value != "") {
      list.add(VideoPlayerWidget(videoUrl: videoUrl.value));
    }
    caraouselWidgets.assignAll(list);
  }

  void fetchSuggestions(String input) async {
    if (input.isEmpty) {
      cities.value = [];
      return;
    }
    final uri = '$hostUrl/api/searchCity?input=$input';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      cities.value = List<String>.from(data['cities']);
      return;
    } else {
      cities.value = [];
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

  void removeImage(int index) {
    images.removeAt(index);
  }

  void editgymDetails() async {
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
      "machines": editMachines
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/edit/gym/details', data: data);
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

  void editCoverDetails() async {
    var data = {
      "user": authController.userId.value,
      "images": imageUrls,
      "video": videoSave.value,
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/edit/gym/cover', data: data);
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

  void editgymSlots() async {
    var data = {
      "user": authController.userId.value,
      "days": editDays,
      "morning_time": mSlots,
      "evening_time": eSlots
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/edit/gym/slots', data: data);
    if (response["success"]) {
      isLoading.value = false;
      showErrorSnackBar(
          heading: "Success",
          message: "Gym slots updated.",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    } else {
      isLoading.value = false;
      showErrorSnackBar(
          heading: "Error",
          message: "Error in updating slots.",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    }
  }

  void editgymPackages(hours, packages) async {
    var data = {
      "user": authController.userId.value,
      "hour_package": hours,
      "packages": packages
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/edit/gym/packages', data: data);
    if (response["success"]) {
      isLoading.value = false;
      showErrorSnackBar(
          heading: "Success",
          message: "Gym packages updated.",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    } else {
      isLoading.value = false;
      showErrorSnackBar(
          heading: "Error",
          message: "Error in updating packages.",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    }
  }

  bool getExist(String id) {
    bool exists = editReviews.any((review) {
      return review["user"] == id;
    });
    return exists;
  }

  void calculateRatingStatistics() {
    Map<String, int> ratingsCount = {'1': 0, '2': 0, '3': 0, '4': 0, '5': 0};
    double totalRating = 0;

    for (var review in editReviews) {
      ratingsCount[review['rating']] =
          (ratingsCount[review['rating']] ?? 0) + 1;
      totalRating += double.parse(review['rating']);
    }
    avgRating.value =
        editReviews.isNotEmpty ? totalRating / editReviews.length : 0;
    starRatings.value = ratingsCount;
  }

  double calculateAverage(item) {
    double totalRating = 0;
    for (var review in item) {
      totalRating += double.parse(review['rating']);
    }
    double average = item.isNotEmpty ? totalRating / item.length : 0;
    return average;
  }

  void editgymReviews(String id) async {
    var data = {
      "id": id,
      "reviews": {
        "user": authController.userId.value,
        "rating": rating.value,
        "review": ""
      }
    };
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/edit/gym/reviews', data: data);
    if (response["success"]) {
      isLoading.value = false;
      showErrorSnackBar(
          heading: "Success",
          message: "Rated gym",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    } else {
      isLoading.value = false;
      showErrorSnackBar(
          heading: "Error",
          message: "Error in rating. Please try again.",
          icon: Icons.sports_gymnastics,
          color: Colors.white);
      return;
    }
  }

  Future<void> getOwnerProfile() async {
    var data = {
      "user": authController.userId.value,
    };
    isLoadingSwitch.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/gym/profile', data: data);
    if (response["success"]) {
      gymId.value = response['gym']['_id'] ?? "";
      nameController.text = response['gym']['name'] ?? "";
      videoUrl.value = response['gym']['video'] ?? "";
      locationController.text = response['gym']['address'] ?? "";
      openingTime.value = response['gym']['opening_time'] ?? "";
      linkController.text = response['gym']['link'] ?? "";
      contactController.text = response['gym']['phone'] ?? "";
      closingTime.value = response['gym']['closing_time'] ?? "";
      selectedGender.value = response['gym']['gender'] ?? 0;
      editMachines.value = response['gym']['machines'] ?? [];
      editReviews.value = response['gym']['reviews'] ?? [];
      editAmenities.value = response['gym']['amenities'] ?? [];
      editabout.value = response['gym']['about'] ?? "";
      hourPackage.value = response['gym']['hour_package'] ?? [];
      if (response['gym']['hour_package'].isNotEmpty) {
        hourController.text = response['gym']['hour_package'][1] ?? "";
      }
      editDays.value = response['gym']['days'] ?? [];
      cityController.text = response['gym']['city'] ?? "";
      if (response['gym']['morning_time'].isNotEmpty) {
        mSlots[0] = response['gym']['morning_time'][0];
        mSlots[1] = response['gym']['morning_time'][1];
      }
      if (response['gym']['evening_time'].isNotEmpty) {
        eSlots[0] = response['gym']['evening_time'][0];
        eSlots[1] = response['gym']['evening_time'][1];
      }
      if (response['gym']['packages'].isNotEmpty) {
        month1Controller.text = response['gym']['packages'][0]['price'] ?? "";
        month3Controller.text = response['gym']['packages'][1]['price'] ?? "";
        month6Controller.text = response['gym']['packages'][2]['price'] ?? "";
        yearController.text = response['gym']['packages'][3]['price'] ?? "";
      }
      imageNetworks.value = response['gym']['images'] ?? [];
      isActive.value = response['gym']['active'];
      isLoadingSwitch.value = false;
      if (response['gym']['images'] != null &&
          response['gym']['images'].isNotEmpty) {
        for (var x in response['gym']['images']) {
          images.add(ImageItem(imageUrl: x));
        }
      }
      if (editReviews.isNotEmpty) {
        calculateRatingStatistics();
      }

      return;
    } else {
      isLoadingSwitch.value = false;

      return;
    }
  }

  Future<void> getGymReviews(id) async {
    var data = {
      "id": id,
    };
    var response = await postRequestUnAuthenticated(
        endpoint: '/get/gym/reviews', data: data);
    if (response["success"]) {
      editReviews.value = response['reviews'] ?? [];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }

  void toggleActive() async {
    var data = {"id": gymId.value};
    isLoading.value = true;
    var response = await postRequestUnAuthenticated(
        endpoint: '/toggle/active', data: data);
    if (response["success"]) {
      isActive.value = response['active'];
      isLoading.value = false;
      return;
    } else {
      isLoading.value = false;
      return;
    }
  }
}
