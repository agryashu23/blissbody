import 'dart:typed_data';

import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:blissbody_app/widgets/video_player.dart';
import 'package:blissbody_app/widgets/video_player2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OwnerEditCover extends StatelessWidget {
  OwnerEditCover({super.key});

  final OwnerHomeController ownerHomeController =
      Get.find<OwnerHomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor:
              authController.isDarkMode.value ? Colors.black : Colors.white,
          elevation: 0,
          title: Text(
            "Edit images & video",
            style: TextStyle(
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
                letterSpacing: 1.5,
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Container(
                height: getH(context) * 0.18,
                margin: EdgeInsets.only(
                  top: getH(context) * 0.02,
                ),
                child: ownerHomeController.images.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ownerHomeController.images.length,
                        itemBuilder: (context, index) {
                          final item = ownerHomeController.images[index];
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: 130,
                                height: getH(context) * 0.17,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: item.isNetworkImage
                                      ? Image.network(item.imageUrl,
                                          fit: BoxFit.cover)
                                      : Image.memory(item.imageData!,
                                          fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                right: 2,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () =>
                                      ownerHomeController.removeImage(index),
                                  child: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : const SizedBox(),
              ),
            ),
            SizedBox(
              height: getH(context) * 0.015,
            ),
            submitBtn(context, "Edit Image", () {
              if (ownerHomeController.images.length >= 4) {
                showErrorSnackBar(
                    heading: "Image exceeded",
                    message: "You can add max. 4 images for cover.",
                    icon: Icons.maximize,
                    color: Colors.white);
              } else {
                ownerHomeController.pickImage(ImageSource.gallery);
              }
            }),
            Container(
              height: getH(context) * 0.2,
              width: getW(context) * 0.9,
              margin: EdgeInsets.only(top: getH(context) * 0.05),
              child: Obx(() {
                if (ownerHomeController.videoUrl.value.isEmpty) {
                  return const SizedBox();
                } else if (ownerHomeController.isAssetVideo.value) {
                  return VideoPlayerWidget2(
                      videoUrl: ownerHomeController.videoUrl.value);
                } else {
                  return VideoPlayerWidget(
                      videoUrl: ownerHomeController.videoUrl.value);
                }
              }),
            ),
            SizedBox(
              height: getH(context) * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: getW(context) * 0.4,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: ColorConst.borderColor, width: 0.6)),
                  child: TextButton(
                    onPressed: () {
                      ownerHomeController.pickVideo(ImageSource.gallery);
                    },
                    child: const Text('Edit Video',
                        style: TextStyle(
                            color: ColorConst.btnColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Container(
                  width: getW(context) * 0.4,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: ColorConst.borderColor, width: 0.6)),
                  child: TextButton(
                    onPressed: () {
                      ownerHomeController.videoUrl.value = "";
                    },
                    child: const Text("Reset",
                        style: TextStyle(
                            color: ColorConst.btnColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: getH(context) * 0.1,
            ),
            Card(
              surfaceTintColor: Colors.white,
              color: ColorConst.websiteHomeBox,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: getW(context) * 0.8,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: ColorConst.borderColor, width: 0.6)),
                child: TextButton(
                  onPressed: () async {
                    if (ownerHomeController.images.isEmpty) {
                      showErrorSnackBar(
                          heading: "Error",
                          message: "Add atleast one image",
                          icon: Icons.error);
                    } else {
                      ownerHomeController.isLoading.value = true;
                      var imageData = <Uint8List>[];
                      for (var img in ownerHomeController.images) {
                        if (img.isNetworkImage == false) {
                          imageData.add(img.imageData!);
                        }
                      }
                      if (imageData.isNotEmpty) {
                        await uploadCoverToS3(imageData);
                        for (var img in ownerHomeController.images) {
                          if (img.isNetworkImage == true) {
                            ownerHomeController.imageUrls.add(img.imageUrl);
                          }
                        }
                      }
                      if (ownerHomeController.videoUrl.isNotEmpty &&
                          ownerHomeController.isAssetVideo.value) {
                        await uploadVideoToS3(
                            ownerHomeController.videoUrl.value);
                      }
                      ownerHomeController.editCoverDetails();
                      ownerHomeController.isLoading.value = false;
                    }
                  },
                  child: Obx(
                    () => Text(
                        ownerHomeController.isLoading.value
                            ? "Please wait..."
                            : "Update",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
