import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:blissbody_app/controllers/adminAddController.dart';
import 'package:blissbody_app/controllers/adminController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/controllers/reelsController.dart';
import 'package:blissbody_app/globals/globals.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

final OwnerHomeController ownerHomeController = Get.find<OwnerHomeController>();
final ProfileController profileController = Get.find<ProfileController>();
final ReelsController reelsController = Get.find<ReelsController>();
final AdminController adminController = Get.find<AdminController>();
final AdminAddController adminAddController = Get.find<AdminAddController>();
Future postRequestUnAuthenticated(
    {required String endpoint,
    Map<String, String>? headers,
    required Map<String, dynamic> data}) async {
  try {
    final url = '$hostUrl/api$endpoint';
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', // Ensure header is set for JSON
          ...?headers // Spread other headers if any
        },
        body: jsonEncode(data) // Encode the data to JSON string
        );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      return {
        "error": true,
        "success": false,
        "message": "Error with status code: ${response.statusCode}"
      };
    }
  } catch (e) {
    return {"error": true, "success": false, "message": "Network Error: $e"};
  }
}

void parseAndSetSuggestions(String responseBody) {
  final parsed = jsonDecode(responseBody);
  if (parsed['status'] == 'OK' && parsed.containsKey('predictions')) {
    final List<dynamic> predictions = parsed['predictions'];
    final List<Map<String, String>> descriptions =
        predictions.map<Map<String, String>>((prediction) {
      final String description = prediction['description'];
      final String placeId = prediction['place_id'];
      final String mapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$description&query_place_id=$placeId';

      return {'description': description, 'mapsUrl': mapsUrl};
    }).toList();
    ownerHomeController.suggestions.clear();
    ownerHomeController.suggestions.addAll(descriptions);
  } else {
    print('No predictions found or status not OK');
  }
}

void fetchSuggestionsplaces(String input) async {
  if (input.isEmpty) {
    ownerHomeController.suggestions.value = [];
    return;
  }
  final String url = '$hostUrl/api/places/autocomplete?input=$input';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      parseAndSetSuggestions(response.body);
    } else {
      print('Failed to fetch suggestions: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching suggestions: $e');
  }
}

void parseAndSetAdminSuggestions(String responseBody) {
  final parsed = jsonDecode(responseBody);
  if (parsed['status'] == 'OK' && parsed.containsKey('predictions')) {
    final List<dynamic> predictions = parsed['predictions'];
    final List<Map<String, String>> descriptions =
        predictions.map<Map<String, String>>((prediction) {
      final String description = prediction['description'];
      final String placeId = prediction['place_id'];
      final String mapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$description&query_place_id=$placeId';

      return {'description': description, 'mapsUrl': mapsUrl};
    }).toList();
    adminAddController.suggestions.clear();
    adminAddController.suggestions.addAll(descriptions);
  } else {
    print('No predictions found or status not OK');
  }
}

void fetchSuggestionsAdminplaces(String input) async {
  if (input.isEmpty) {
    adminAddController.suggestions.value = [];
    return;
  }
  final String url = '$hostUrl/api/places/autocomplete?input=$input';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      parseAndSetAdminSuggestions(response.body);
    } else {
      print('Failed to fetch suggestions: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching suggestions: $e');
  }
}

Future<void> uploadImageToS3(RxList<Uint8List> imageBytes) async {
  profileController.isLoading.value = true;

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/upload/image'),
  );
  profileController.isLoading.value = true;

  var bytes = imageBytes[0];
  var multipartFile = http.MultipartFile.fromBytes(
    'file',
    bytes,
    filename: 'image.jpg',
    contentType: MediaType('image', 'jpeg'),
  );

  request.files.add(multipartFile);

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      profileController.imageUrl.value = responseJson['urls'][0];
      profileController.isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading image",
          icon: Icons.error,
          color: Colors.white);
      profileController.isLoading.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading image",
        icon: Icons.error,
        color: Colors.white);
    profileController.isLoading.value = false;
  }
}

Future<void> uploadReelImageToS3(RxList<Uint8List> imageBytes) async {
  reelsController.isLoading.value = true;

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/reel/image'),
  );
  reelsController.isLoading.value = true;

  var bytes = imageBytes[0];
  var multipartFile = http.MultipartFile.fromBytes(
    'file',
    bytes,
    filename: 'image.jpg',
    contentType: MediaType('image', 'jpeg'),
  );

  request.files.add(multipartFile);

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      reelsController.videoUrl.value = responseJson['urls'][0];
      reelsController.isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading image",
          icon: Icons.error,
          color: Colors.white);
      reelsController.isLoading.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading image",
        icon: Icons.error,
        color: Colors.white);
    profileController.isLoading.value = false;
  }
}

Future<void> uploadCoverToS3(List<Uint8List> imageBytesList) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/upload/cover'),
  );
  ownerHomeController.isLoading.value = true;

  for (int i = 0; i < imageBytesList.length; i++) {
    var bytes = imageBytesList[i];
    var multipartFile = http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: 'image$i.jpg',
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);
  }

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      ownerHomeController.imageUrls = List<String>.from(responseJson['urls']);
      ownerHomeController.isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading images",
          icon: Icons.error,
          color: Colors.white);
      ownerHomeController.isLoading.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading images",
        icon: Icons.error,
        color: Colors.white);
    ownerHomeController.isLoading.value = false;
  }
}

Future<void> uploadCoverAdminToS3(List<Uint8List> imageBytesList) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/upload/cover'),
  );
  adminAddController.isLoading.value = true;

  for (int i = 0; i < imageBytesList.length; i++) {
    var bytes = imageBytesList[i];
    var multipartFile = http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: 'image$i.jpg',
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);
  }

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      adminAddController.imageUrls = List<String>.from(responseJson['urls']);
      adminAddController.isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading images",
          icon: Icons.error,
          color: Colors.white);
      adminAddController.isLoading.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading images",
        icon: Icons.error,
        color: Colors.white);
    adminAddController.isLoading.value = false;
  }
}

Future<void> uploadCoverAdmin2ToS3(List<Uint8List> imageBytesList) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/upload/cover'),
  );
  adminController.isLoading.value = true;

  for (int i = 0; i < imageBytesList.length; i++) {
    var bytes = imageBytesList[i];
    var multipartFile = http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: 'image$i.jpg',
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);
  }

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      adminController.imageUrls = List<String>.from(responseJson['urls']);
      adminController.isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading images",
          icon: Icons.error,
          color: Colors.white);
      adminController.isLoading.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading images",
        icon: Icons.error,
        color: Colors.white);
    adminController.isLoading.value = false;
  }
}

Future<void> uploadVideoToS3(String videoPath) async {
  profileController.isLoading.value = true;

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/upload/video'),
  );

  var videoBytes = await File(videoPath).readAsBytes();
  var multipartFile = http.MultipartFile.fromBytes(
    'file',
    videoBytes,
    filename: 'video.mp4',
    contentType: MediaType('video', 'mp4'),
  );
  request.files.add(multipartFile);
  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      ownerHomeController.videoSave.value = responseJson['urls'][0];
      ownerHomeController.isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading video",
          icon: Icons.error,
          color: Colors.white);
      ownerHomeController.isLoading.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading video",
        icon: Icons.error,
        color: Colors.white);
    ownerHomeController.isLoading.value = false;
  }
}

Future<void> uploadVideoAdminToS3(String videoPath) async {
  adminAddController.isLoading.value = true;

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/upload/video'),
  );

  var videoBytes = await File(videoPath).readAsBytes();
  var multipartFile = http.MultipartFile.fromBytes(
    'file',
    videoBytes,
    filename: 'video.mp4',
    contentType: MediaType('video', 'mp4'),
  );

  request.files.add(multipartFile);

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      adminAddController.videoSave.value = responseJson['urls'][0];
      adminAddController.isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading video",
          icon: Icons.error,
          color: Colors.white);
      adminAddController.isLoading.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading video",
        icon: Icons.error,
        color: Colors.white);
    adminAddController.isLoading.value = false;
  }
}

Future<void> uploadVideoAdmin2ToS3(String videoPath) async {
  adminController.isLoading.value = true;

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/upload/video'),
  );

  var videoBytes = await File(videoPath).readAsBytes();
  var multipartFile = http.MultipartFile.fromBytes(
    'file',
    videoBytes,
    filename: 'video.mp4',
    contentType: MediaType('video', 'mp4'),
  );

  request.files.add(multipartFile);

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      adminController.videoSave.value = responseJson['urls'][0];
      adminController.isLoading.value = false;
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading video",
          icon: Icons.error,
          color: Colors.white);
      adminController.isLoading.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading video",
        icon: Icons.error,
        color: Colors.white);
    adminAddController.isLoading.value = false;
  }
}

Future<void> uploadReelToS3(String videoPath) async {
  reelsController.isLoadingValue.value = true;
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$hostUrl/api/upload/reel'),
  );
  var videoBytes = await File(videoPath).readAsBytes();
  var multipartFile = http.MultipartFile.fromBytes(
    'file',
    videoBytes,
    filename: 'video.mp4',
    contentType: MediaType('video', 'mp4'),
  );

  request.files.add(multipartFile);

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      reelsController.videoUrl.value = responseJson['urls'][0];
    } else {
      showErrorSnackBar(
          heading: "Uploading error",
          message: "Error in uploading video",
          icon: Icons.error,
          color: Colors.white);
      reelsController.isLoadingValue.value = false;
    }
  } catch (e) {
    showErrorSnackBar(
        heading: "Uploading error",
        message: "Error in uploading video",
        icon: Icons.error,
        color: Colors.white);
    reelsController.isLoading.value = false;
  }
}
