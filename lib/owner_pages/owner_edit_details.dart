import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class OwnerEditDetails extends StatelessWidget {
  OwnerEditDetails({super.key});
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
            "Edit your gym details",
            style: TextStyle(
                fontSize: 17,
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
                letterSpacing: 1.5,
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
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                                ownerHomeController.nameController,
                                "Name for your gym?",
                                TextInputType.name)),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: getH(context) * 0.025),
                          child: labelName(context, "Search address")),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          controller: ownerHomeController.locationController,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: authController.isDarkMode.value
                                ? Colors.white
                                : ColorConst.titleColor,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter location",
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: true,
                            fillColor: authController.isDarkMode.value
                                ? ColorConst.dark
                                : Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                          ),
                          onChanged: fetchSuggestionsplaces,
                        ),
                      ),
                      Obx(
                        () => ownerHomeController.suggestions.isNotEmpty
                            ? SizedBox(
                                height: getH(context) * 0.3,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount:
                                      ownerHomeController.suggestions.length,
                                  itemBuilder: (context, index) {
                                    final suggestion =
                                        ownerHomeController.suggestions[index];
                                    return ListTile(
                                      leading: const Icon(Icons.location_on),
                                      title: Text(
                                        suggestion['description'].toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Inter',
                                            color: ColorConst.primaryGrey),
                                      ),
                                      onTap: () {
                                        ownerHomeController
                                                .locationController.text =
                                            suggestion['description']
                                                .toString();
                                        ownerHomeController.suggestions.clear();
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
                          controller: ownerHomeController.cityController,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: authController.isDarkMode.value
                                ? Colors.white
                                : ColorConst.titleColor,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter city",
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: true,
                            fillColor: authController.isDarkMode.value
                                ? ColorConst.dark
                                : Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                          ),
                          onChanged: ownerHomeController.fetchSuggestions,
                        ),
                      ),
                      Obx(
                        () => ownerHomeController.cities.isNotEmpty
                            ? SizedBox(
                                height: getH(context) * 0.3,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: ownerHomeController.cities.length,
                                  itemBuilder: (context, index) {
                                    final city =
                                        ownerHomeController.cities[index];
                                    return ListTile(
                                      leading: const Icon(Icons.location_on),
                                      title: Text(
                                        city.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Inter',
                                            color: ColorConst.primaryGrey),
                                      ),
                                      onTap: () {
                                        ownerHomeController.cities.clear();
                                        ownerHomeController
                                            .cityController.text = city;
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
                                ownerHomeController.linkController,
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
                                ownerHomeController.contactController,
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
                                  margin: EdgeInsets.only(
                                      top: getH(context) * 0.025),
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
                                    final minute = newTime.minute
                                        .toString()
                                        .padLeft(2, '0');
                                    ownerHomeController.openingTime.value =
                                        "$hour:$minute";
                                  }
                                },
                                child: Container(
                                  width: getW(context) * 0.3,
                                  decoration: BoxDecoration(
                                      color: authController.isDarkMode.value
                                          ? ColorConst.dark
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8)),
                                  height: getH(context) * 0.05,
                                  alignment: Alignment.center,
                                  child: Obx(() => Text(
                                        ownerHomeController.openingTime.value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                authController.isDarkMode.value
                                                    ? Colors.white
                                                    : ColorConst.titleColor,
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
                                  margin: EdgeInsets.only(
                                      top: getH(context) * 0.025),
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
                                    final minute = newTime.minute
                                        .toString()
                                        .padLeft(2, '0');
                                    ownerHomeController.closingTime.value =
                                        "$hour:$minute";
                                  }
                                },
                                child: Container(
                                  width: getW(context) * 0.3,
                                  decoration: BoxDecoration(
                                      color: authController.isDarkMode.value
                                          ? ColorConst.dark
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8)),
                                  height: getH(context) * 0.05,
                                  alignment: Alignment.center,
                                  child: Obx(() => Text(
                                        ownerHomeController.closingTime.value,
                                        style: TextStyle(
                                            color:
                                                authController.isDarkMode.value
                                                    ? Colors.white
                                                    : ColorConst.titleColor,
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
                                ownerHomeController.selectedGender.value,
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
                              ownerHomeController.selectedGender.value = index;
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
                          initialValue: ownerHomeController.editabout.value,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: authController.isDarkMode.value
                                  ? Colors.white
                                  : ColorConst.titleColor,
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
                            fillColor: authController.isDarkMode.value
                                ? ColorConst.dark
                                : Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                          ),
                          maxLines: 4,
                          onChanged: (value) {
                            ownerHomeController.editabout.value = value;
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
                                  style: TextStyle(
                                    color: authController.isDarkMode.value
                                        ? Colors.white
                                        : ColorConst.titleColor,
                                  ),
                                ),
                                dense: true,
                                activeColor: ColorConst.websiteHomeBox,
                                secondary: Icon(
                                  amenities[index]['icon'],
                                  color: authController.isDarkMode.value
                                      ? Colors.white
                                      : ColorConst.titleColor,
                                ),
                                value: ownerHomeController.editAmenities
                                    .contains(amenities[index]['name']),
                                onChanged: (bool? newValue) {
                                  if (ownerHomeController.editAmenities
                                      .contains(amenities[index]['name'])) {
                                    ownerHomeController.editAmenities
                                        .remove(amenities[index]['name']);
                                  } else {
                                    ownerHomeController.editAmenities
                                        .add(amenities[index]['name']);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: getH(context) * 0.03,
                      ),
                      Center(
                          child: submitBtn(context, "Update", () async {
                        if (ownerHomeController.nameController.text.isEmpty ||
                            ownerHomeController
                                .locationController.text.isEmpty ||
                            ownerHomeController.cityController.text.isEmpty ||
                            ownerHomeController.openingTime.isEmpty ||
                            ownerHomeController.closingTime.isEmpty ||
                            ownerHomeController.editabout.isEmpty ||
                            ownerHomeController.editAmenities.isEmpty) {
                          showErrorSnackBar(
                              heading: "Empty fields",
                              message: "Please enter all fields",
                              icon: Icons.person);
                        } else {
                          ownerHomeController.editgymDetails();
                        }
                      })),
                      SizedBox(
                        height: getH(context) * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
