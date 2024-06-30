import 'dart:typed_data';

import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/adminAddController.dart';
import 'package:blissbody_app/controllers/adminController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/owner_pages/widgets/packageCard.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:blissbody_app/widgets/video_player.dart';
import 'package:blissbody_app/widgets/video_player2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddGym extends StatefulWidget {
  const AdminAddGym({super.key});

  @override
  State<AdminAddGym> createState() => _AdminAddGymState();
}

class _AdminAddGymState extends State<AdminAddGym> {
  final AdminAddController adminAddController = Get.find<AdminAddController>();
  final AdminController adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Gym",
          style: TextStyle(
            fontSize: 17,
            color: ColorConst.titleColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: getW(context) * 0.04, right: getW(context) * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.02),
                        child: labelName(context, "Gym Name")),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: getH(context) * 0.005),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: editTextField(
                              adminAddController.nameController,
                              "Name for your gym?",
                              TextInputType.name)),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.025),
                        child: labelName(context, "Search address")),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: adminAddController.locationController,
                        style: const TextStyle(
                            fontFamily: 'Inter', color: ColorConst.titleColor),
                        decoration: InputDecoration(
                          hintText: "Enter location",
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                        ),
                        onChanged: fetchSuggestionsAdminplaces,
                      ),
                    ),
                    Obx(
                      () => adminAddController.suggestions.isNotEmpty
                          ? SizedBox(
                              height: getH(context) * 0.3,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount:
                                    adminAddController.suggestions.length,
                                itemBuilder: (context, index) {
                                  final suggestion =
                                      adminAddController.suggestions[index];
                                  return ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: Text(
                                      suggestion['description'].toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          color: ColorConst.primaryGrey),
                                    ),
                                    onTap: () {
                                      adminAddController
                                              .locationController.text =
                                          suggestion['description'].toString();
                                      adminAddController.suggestions.clear();
                                    },
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.025),
                        child: labelName(context, "Search city")),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: adminAddController.cityController,
                        style: const TextStyle(
                            fontFamily: 'Inter', color: ColorConst.titleColor),
                        decoration: InputDecoration(
                          hintText: "Enter city",
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                        ),
                        onChanged: adminAddController.fetchSuggestions,
                      ),
                    ),
                    Obx(
                      () => adminAddController.cities.isNotEmpty
                          ? SizedBox(
                              height: getH(context) * 0.3,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: adminAddController.cities.length,
                                itemBuilder: (context, index) {
                                  final city = adminAddController.cities[index];
                                  return ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: Text(
                                      city.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          color: ColorConst.primaryGrey),
                                    ),
                                    onTap: () {
                                      adminAddController.cities.clear();
                                      adminAddController.cityController.text =
                                          city;
                                    },
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.02),
                        child: labelName(context, "Website link (optional)")),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: getH(context) * 0.005),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: editTextField(
                              adminAddController.linkController,
                              "Link for your gym?",
                              TextInputType.text)),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.02),
                        child: labelName(context, "Contact No.")),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: getH(context) * 0.005),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: editTextField(
                              adminAddController.contactController,
                              "Contact for your gym?",
                              TextInputType.number)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    EdgeInsets.only(top: getH(context) * 0.025),
                                child: labelName(context, "Opening Time")),
                            GestureDetector(
                              onTap: () async {
                                final newTime = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      const TimeOfDay(hour: 06, minute: 00),
                                  initialEntryMode: TimePickerEntryMode.dial,
                                );
                                if (newTime != null) {
                                  final hour =
                                      newTime.hour.toString().padLeft(2, '0');
                                  final minute =
                                      newTime.minute.toString().padLeft(2, '0');
                                  adminAddController.openingTime.value =
                                      "$hour:$minute";
                                }
                              },
                              child: Container(
                                width: getW(context) * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8)),
                                height: getH(context) * 0.05,
                                alignment: Alignment.center,
                                child: Obx(() => Text(
                                      adminAddController.openingTime.value,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    EdgeInsets.only(top: getH(context) * 0.025),
                                child: labelName(context, "Closing Time")),
                            GestureDetector(
                              onTap: () async {
                                final newTime = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      const TimeOfDay(hour: 22, minute: 00),
                                  initialEntryMode: TimePickerEntryMode.dial,
                                );
                                if (newTime != null) {
                                  final hour =
                                      newTime.hour.toString().padLeft(2, '0');
                                  final minute =
                                      newTime.minute.toString().padLeft(2, '0');
                                  adminAddController.closingTime.value =
                                      "$hour:$minute";
                                }
                              },
                              child: Container(
                                width: getW(context) * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8)),
                                height: getH(context) * 0.05,
                                alignment: Alignment.center,
                                child: Obx(() => Text(
                                      adminAddController.closingTime.value,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Obx(
                      () => Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: getH(context) * 0.025),
                        child: FlutterToggleTab(
                          width: getW(context) * 0.22,
                          borderRadius: 8,
                          height: 40,
                          selectedIndex:
                              adminAddController.selectedGender.value,
                          selectedBackgroundColors: const [
                            ColorConst.websiteHomeBox,
                          ],
                          unSelectedBackgroundColors: const [
                            ColorConst.borderColor
                          ],
                          selectedTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          unSelectedTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          labels: const ["Male", "Female", "Both"],
                          selectedLabelIndex: (index) {
                            adminAddController.selectedGender.value = index;
                          },
                          isScroll: false,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.025),
                        child: labelName(context, "About your gym")),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        initialValue: adminAddController.editabout.value,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            color: ColorConst.titleColor,
                            fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "Make a description for your gym",
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                        ),
                        maxLines: 4,
                        onChanged: (value) {
                          adminAddController.editabout.value = value;
                        },
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.025),
                        child: labelName(context, "Amenities")),
                    SizedBox(
                      height: getH(context) * 0.3,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: amenities.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => CheckboxListTile(
                              title: Text(
                                amenities[index]['name'],
                                style: const TextStyle(
                                  color: ColorConst.titleColor,
                                ),
                              ),
                              dense: true,
                              activeColor: ColorConst.websiteHomeBox,
                              secondary: Icon(
                                amenities[index]['icon'],
                                color: ColorConst.titleColor,
                              ),
                              value: adminAddController.editAmenities
                                  .contains(amenities[index]['name']),
                              onChanged: (bool? newValue) {
                                if (adminAddController.editAmenities
                                    .contains(amenities[index]['name'])) {
                                  adminAddController.editAmenities
                                      .remove(amenities[index]['name']);
                                } else {
                                  adminAddController.editAmenities
                                      .add(amenities[index]['name']);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Obx(
                      () => adminAddController.images.isNotEmpty
                          ? Container(
                              height: getH(context) * 0.18,
                              margin: EdgeInsets.only(
                                top: getH(context) * 0.02,
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: adminAddController.images.length,
                                itemBuilder: (context, index) {
                                  final item = adminAddController.images[index];
                                  return Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        width: 130,
                                        height: getH(context) * 0.17,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          onTap: () => adminAddController
                                              .removeImage(index),
                                          child: const Icon(Icons.delete,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ))
                          : const SizedBox(),
                    ),
                    SizedBox(
                      height: getH(context) * 0.015,
                    ),
                    Center(
                      child: submitBtn(context, "Edit Image", () {
                        if (adminAddController.images.length >= 4) {
                          showErrorSnackBar(
                              heading: "Image exceeded",
                              message: "You can add max. 4 images for cover.",
                              icon: Icons.maximize,
                              color: Colors.white);
                        } else {
                          adminAddController.pickImage(ImageSource.gallery);
                        }
                      }),
                    ),
                    Obx(
                      () => adminAddController.videoUrl.isEmpty
                          ? const SizedBox()
                          : Container(
                              height: getH(context) * 0.2,
                              width: getW(context) * 0.9,
                              margin:
                                  EdgeInsets.only(top: getH(context) * 0.05),
                              child: VideoPlayerWidget2(
                                  videoUrl: adminAddController.videoUrl.value),
                            ),
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
                              adminAddController.pickVideo(ImageSource.gallery);
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
                              adminAddController.videoUrl.value = "";
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
                      height: getH(context) * 0.02,
                    ),
                    SizedBox(
                      height: getH(context) * 0.7,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: machines.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => CheckboxListTile(
                              title: Text(
                                machines[index],
                                style: const TextStyle(
                                  color: ColorConst.titleColor,
                                ),
                              ),
                              dense: true,
                              activeColor: ColorConst.websiteHomeBox,
                              value: adminAddController.editMachines
                                  .contains(machines[index]),
                              onChanged: (bool? newValue) {
                                if (adminAddController.editMachines
                                    .contains(machines[index])) {
                                  adminAddController.editMachines
                                      .remove(machines[index]);
                                } else {
                                  adminAddController.editMachines
                                      .add(machines[index]);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                        child: labelName(
                            context, "Create hourly package (Optional)")),
                    packageCard(
                        context, adminAddController.hourController, "1 Hour"),
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.02),
                        child: labelName(context, "Create monthly package")),
                    packageCard(context, adminAddController.month1Controller,
                        "1 Month"),
                    packageCard(context, adminAddController.month3Controller,
                        "3 Months"),
                    packageCard(context, adminAddController.month6Controller,
                        "6 Months"),
                    packageCard(
                        context, adminAddController.yearController, "1 Year"),
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: getH(context) * 0.01),
                child: labelName(context, "Opening days")),
            SizedBox(
              height: getH(context) * 0.43,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: days.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => CheckboxListTile(
                      title: Text(
                        days[index],
                        style: const TextStyle(
                            color: ColorConst.titleColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      dense: true,
                      activeColor: ColorConst.websiteHomeBox,
                      value: adminAddController.editDays.contains(days[index]),
                      onChanged: (bool? newValue) {
                        if (adminAddController.editDays.contains(days[index])) {
                          adminAddController.editDays.remove(days[index]);
                        } else {
                          adminAddController.editDays.add(days[index]);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: getH(context) * 0.015),
                child: labelName(context, "Morning Slot")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.02),
                        child: labelName(context, "Opening Time")),
                    GestureDetector(
                      onTap: () async {
                        final newTime = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 06, minute: 00),
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        if (newTime != null) {
                          final hour = newTime.hour.toString().padLeft(2, '0');
                          adminAddController.mSlots[0] = "$hour:00";
                        }
                      },
                      child: Container(
                        width: getW(context) * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        height: getH(context) * 0.05,
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                              adminAddController.mSlots[0],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            )),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.02),
                        child: labelName(context, "Closing Time")),
                    GestureDetector(
                      onTap: () async {
                        final newTime = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 10, minute: 00),
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        if (newTime != null) {
                          final hour = newTime.hour.toString().padLeft(2, '0');
                          adminAddController.mSlots[1] = "$hour:00";
                        }
                      },
                      child: Container(
                        width: getW(context) * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        height: getH(context) * 0.05,
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                              adminAddController.mSlots[1],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: getH(context) * 0.04),
                child: labelName(context, "Evening Slot")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.02),
                        child: labelName(context, "Opening Time")),
                    GestureDetector(
                      onTap: () async {
                        final newTime = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 16, minute: 00),
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        if (newTime != null) {
                          final hour = newTime.hour.toString().padLeft(2, '0');
                          adminAddController.eSlots[0] = "$hour:00";
                        }
                      },
                      child: Container(
                        width: getW(context) * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        height: getH(context) * 0.05,
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                              adminAddController.eSlots[0],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            )),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.02),
                        child: labelName(context, "Closing Time")),
                    GestureDetector(
                      onTap: () async {
                        final newTime = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 22, minute: 00),
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        if (newTime != null) {
                          final hour = newTime.hour.toString().padLeft(2, '0');
                          adminAddController.eSlots[1] = "$hour:00";
                        }
                      },
                      child: Container(
                        width: getW(context) * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        height: getH(context) * 0.05,
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                              adminAddController.eSlots[1],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: getH(context) * 0.03,
            ),
            Obx(
              () => submitBtn(
                  context,
                  adminAddController.isLoading.value
                      ? "Please wait..."
                      : "Add Gym", () async {
                if (adminAddController.allCheck() == false) {
                  showErrorSnackBar(
                      heading: "Empty fields",
                      message: "Please enter all fields",
                      icon: Icons.person);
                } else {
                  var imageData = <Uint8List>[];
                  for (var img in adminAddController.images) {
                    if (img.isNetworkImage == false) {
                      imageData.add(img.imageData!);
                    }
                  }
                  if (imageData.isNotEmpty) {
                    await uploadCoverAdminToS3(imageData);
                    for (var img in adminAddController.images) {
                      if (img.isNetworkImage == true) {
                        adminAddController.imageUrls.add(img.imageUrl);
                      }
                    }
                  }
                  if (adminAddController.videoUrl.isNotEmpty &&
                      adminAddController.isAssetVideo.value) {
                    await uploadVideoAdminToS3(
                        adminAddController.videoUrl.value);
                  }
                  var hours = [
                    "1 Hour",
                    adminAddController.hourController.text
                  ];
                  var packages = [
                    {
                      "name": "1 Month",
                      "price": adminAddController.month1Controller.text
                    },
                    {
                      "name": "3 Months",
                      "price": adminAddController.month3Controller.text
                    },
                    {
                      "name": "6 Months",
                      "price": adminAddController.month6Controller.text
                    },
                    {
                      "name": "1 Year",
                      "price": adminAddController.yearController.text
                    },
                  ].obs;
                  await adminAddController.createGym(hours, packages);
                  await adminController.getAdminGyms();
                }
              }),
            ),
            SizedBox(
              height: getH(context) * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
