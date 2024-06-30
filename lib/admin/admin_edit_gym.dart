import 'dart:typed_data';

import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/adminController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/owner_pages/widgets/packageCard.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:blissbody_app/widgets/video_player2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminEditGym extends StatefulWidget {
  const AdminEditGym({super.key});

  @override
  State<AdminEditGym> createState() => _AdminEditGymState();
}

class _AdminEditGymState extends State<AdminEditGym> {
  final AdminController adminController = Get.find<AdminController>();

  var id = Get.arguments as String;

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
                          child: editTextField(adminController.nameController,
                              "Name for your gym?", TextInputType.name)),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.025),
                        child: labelName(context, "Search address")),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: adminController.locationController,
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
                      () => adminController.suggestions.isNotEmpty
                          ? SizedBox(
                              height: getH(context) * 0.3,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: adminController.suggestions.length,
                                itemBuilder: (context, index) {
                                  final suggestion =
                                      adminController.suggestions[index];
                                  return ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: Text(
                                      suggestion['description'].toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          color: ColorConst.primaryGrey),
                                    ),
                                    onTap: () {
                                      adminController.locationController.text =
                                          suggestion['description'].toString();
                                      adminController.suggestions.clear();
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
                        controller: adminController.cityController,
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
                        onChanged: adminController.fetchSuggestions,
                      ),
                    ),
                    Obx(
                      () => adminController.cities.isNotEmpty
                          ? SizedBox(
                              height: getH(context) * 0.3,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: adminController.cities.length,
                                itemBuilder: (context, index) {
                                  final city = adminController.cities[index];
                                  return ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: Text(
                                      city.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          color: ColorConst.primaryGrey),
                                    ),
                                    onTap: () {
                                      adminController.cities.clear();
                                      adminController.cityController.text =
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
                          child: editTextField(adminController.linkController,
                              "Link for your gym?", TextInputType.text)),
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
                              adminController.contactController,
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
                                  adminController.openingTime.value =
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
                                      adminController.openingTime.value,
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
                                  adminController.closingTime.value =
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
                                      adminController.closingTime.value,
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
                          selectedIndex: adminController.selectedGender.value,
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
                            adminController.selectedGender.value = index;
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
                        initialValue: adminController.editabout.value,
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
                          adminController.editabout.value = value;
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
                              value: adminController.editAmenities
                                  .contains(amenities[index]['name']),
                              onChanged: (bool? newValue) {
                                if (adminController.editAmenities
                                    .contains(amenities[index]['name'])) {
                                  adminController.editAmenities
                                      .remove(amenities[index]['name']);
                                } else {
                                  adminController.editAmenities
                                      .add(amenities[index]['name']);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Obx(
                      () => adminController.images.isNotEmpty
                          ? Container(
                              height: getH(context) * 0.18,
                              margin: EdgeInsets.only(
                                top: getH(context) * 0.02,
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: adminController.images.length,
                                itemBuilder: (context, index) {
                                  final item = adminController.images[index];
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
                                          onTap: () => adminController
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
                        if (adminController.images.length >= 4) {
                          showErrorSnackBar(
                              heading: "Image exceeded",
                              message: "You can add max. 4 images for cover.",
                              icon: Icons.maximize,
                              color: Colors.white);
                        } else {
                          adminController.pickImage(ImageSource.gallery);
                        }
                      }),
                    ),
                    Obx(
                      () => adminController.videoUrl.isEmpty
                          ? const SizedBox()
                          : Container(
                              height: getH(context) * 0.2,
                              width: getW(context) * 0.9,
                              margin:
                                  EdgeInsets.only(top: getH(context) * 0.05),
                              child: VideoPlayerWidget2(
                                  videoUrl: adminController.videoUrl.value),
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
                              adminController.pickVideo(ImageSource.gallery);
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
                              adminController.videoUrl.value = "";
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
                              value: adminController.editMachines
                                  .contains(machines[index]),
                              onChanged: (bool? newValue) {
                                if (adminController.editMachines
                                    .contains(machines[index])) {
                                  adminController.editMachines
                                      .remove(machines[index]);
                                } else {
                                  adminController.editMachines
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
                        context, adminController.hourController, "1 Hour"),
                    Container(
                        margin: EdgeInsets.only(top: getH(context) * 0.02),
                        child: labelName(context, "Create monthly package")),
                    packageCard(
                        context, adminController.month1Controller, "1 Month"),
                    packageCard(
                        context, adminController.month3Controller, "3 Months"),
                    packageCard(
                        context, adminController.month6Controller, "6 Months"),
                    packageCard(
                        context, adminController.yearController, "1 Year"),
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
                      value: adminController.editDays.contains(days[index]),
                      onChanged: (bool? newValue) {
                        if (adminController.editDays.contains(days[index])) {
                          adminController.editDays.remove(days[index]);
                        } else {
                          adminController.editDays.add(days[index]);
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
                          adminController.mSlots[0] = "$hour:00";
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
                              adminController.mSlots[0],
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
                          adminController.mSlots[1] = "$hour:00";
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
                              adminController.mSlots[1],
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
                          adminController.eSlots[0] = "$hour:00";
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
                              adminController.eSlots[0],
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
                          adminController.eSlots[1] = "$hour:00";
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
                              adminController.eSlots[1],
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
                  adminController.isLoading.value
                      ? "Please wait..."
                      : "Add Gym", () async {
                if (adminController.allCheck() == false) {
                  showErrorSnackBar(
                      heading: "Empty fields",
                      message: "Please enter all fields",
                      icon: Icons.person);
                } else {
                  var imageData = <Uint8List>[];
                  for (var img in adminController.images) {
                    if (img.isNetworkImage == false) {
                      imageData.add(img.imageData!);
                    }
                  }
                  if (imageData.isNotEmpty) {
                    await uploadCoverAdmin2ToS3(imageData);
                    for (var img in adminController.images) {
                      if (img.isNetworkImage == true) {
                        adminController.imageUrls.add(img.imageUrl);
                      }
                    }
                  }
                  if (adminController.videoUrl.isNotEmpty &&
                      adminController.isAssetVideo.value) {
                    await uploadVideoAdmin2ToS3(adminController.videoUrl.value);
                  }
                  var hours = ["1 Hour", adminController.hourController.text];
                  var packages = [
                    {
                      "name": "1 Month",
                      "price": adminController.month1Controller.text
                    },
                    {
                      "name": "3 Months",
                      "price": adminController.month3Controller.text
                    },
                    {
                      "name": "6 Months",
                      "price": adminController.month6Controller.text
                    },
                    {
                      "name": "1 Year",
                      "price": adminController.yearController.text
                    },
                  ].obs;
                  await adminController.editGym(hours, packages, id);
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
