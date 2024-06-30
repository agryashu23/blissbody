import 'dart:convert';
import 'dart:io';

import 'package:blissbody_app/constants/images.dart';
import 'package:blissbody_app/globals/globals.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/utils/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController searchCityController = TextEditingController();
  final TextEditingController searchGymController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
      scaffoldKey.currentState?.openEndDrawer();
    } else {
      scaffoldKey.currentState?.openDrawer();
    }
  }

  var searchValue = "".obs;
  var searchCityValue = "".obs;
  var currentCity = "Mumbai".obs;
  var currentPosition = Rx<Position?>(null);
  var cities = [].obs;
  var isLoading = false.obs;
  var selectedIndex = 0.obs;

  var gyms = [].obs;
  var fileType = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await getLocation();
    getGyms();
  }

  RxList<Map<String, String>> nearbyGym = [
    {
      "image": onboard1Image,
      "name": "Gym 1",
      "address": "Susuwahi gate",
      "city": "Varanasi"
    },
    {
      "image": onboard1Image,
      "name": "Gym 2",
      "address": "Susuwahi gate",
      "city": "Varanasi"
    },
    {
      "image": onboard1Image,
      "name": "Gym 3",
      "address": "Susuwahi gate",
      "city": "Varanasi"
    }
  ].obs;

  Future<void> pickVideo() async {
    final XFile? file =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file != null) {
      var videoFile = File(file.path);
      fileType.value = "video";
      Get.toNamed('/create/reel', arguments: videoFile);
    }
  }

  var imageFile = Rx<File?>(null);
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      var imageFile = File(file.path);
      RxList<Uint8List> pickedImage = <Uint8List>[].obs;
      final imageBytes = await imageFile.readAsBytes();
      pickedImage.add(imageBytes);
      fileType.value = "image";
      Get.toNamed('/create/reel/image', arguments: pickedImage);
    }
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour > 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour > 12 && hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  void onTapped(index) {
    selectedIndex.value = index;
  }

  List initialCities = [
    'Varanasi',
    "Mumbai",
    "Bangalore",
    "Kolkata",
    "Delhi",
    "Ahmedabad",
    "Chandigarh"
  ];

  getLocation() async {
    bool permission = await handleLocationPermission();
    if (permission) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        currentPosition.value = position;
      }).catchError((e) {
        debugPrint(e);
      });
      await placemarkFromCoordinates(
              currentPosition.value!.latitude, currentPosition.value!.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        currentCity.value = place.locality.toString();
      }).catchError((e) {
        debugPrint(e.toString());
      });
    } else {}
  }

  Future<void> getGyms() async {
    var data = {
      "city": currentCity.value,
    };
    isLoading.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/get/gyms', data: data);
    if (response["success"]) {
      gyms = List.from(response["gym"]).obs;
      isLoading.value = false;
      return;
    } else {
      gyms.value = [];
      isLoading.value = false;
      return;
    }
  }

  var searchGymValues = [].obs;

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

  void searchGyms(String name) async {
    if (name.isEmpty) {
      searchGymValues.value = [];
      return;
    }
    var data = {
      "name": name,
    };
    isLoading.value = true;
    var response =
        await postRequestUnAuthenticated(endpoint: '/search/gyms', data: data);
    if (response["success"]) {
      searchGymValues = List.from(response["gym"]).obs;
      isLoading.value = false;
      return;
    } else {
      searchGymValues.value = [];
      isLoading.value = false;
      return;
    }
  }
}
