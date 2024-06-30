import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerEditSlots extends StatelessWidget {
  OwnerEditSlots({super.key});
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
            "Edit Slots",
            style: TextStyle(
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
                letterSpacing: 1.5,
                fontSize: 19,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                          style: TextStyle(
                              color: authController.isDarkMode.value
                                  ? Colors.white
                                  : ColorConst.titleColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        dense: true,
                        activeColor: ColorConst.websiteHomeBox,
                        value:
                            ownerHomeController.editDays.contains(days[index]),
                        onChanged: (bool? newValue) {
                          if (ownerHomeController.editDays
                              .contains(days[index])) {
                            ownerHomeController.editDays.remove(days[index]);
                          } else {
                            ownerHomeController.editDays.add(days[index]);
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
                            final hour =
                                newTime.hour.toString().padLeft(2, '0');
                            ownerHomeController.mSlots[0] = "$hour:00";
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
                                ownerHomeController.mSlots[0],
                                style: TextStyle(
                                    color: authController.isDarkMode.value
                                        ? Colors.white
                                        : ColorConst.titleColor,
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
                            final hour =
                                newTime.hour.toString().padLeft(2, '0');
                            ownerHomeController.mSlots[1] = "$hour:00";
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
                                ownerHomeController.mSlots[1],
                                style: TextStyle(
                                    color: authController.isDarkMode.value
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
                            final hour =
                                newTime.hour.toString().padLeft(2, '0');
                            ownerHomeController.eSlots[0] = "$hour:00";
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
                                ownerHomeController.eSlots[0],
                                style: TextStyle(
                                    color: authController.isDarkMode.value
                                        ? Colors.white
                                        : ColorConst.titleColor,
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
                            final hour =
                                newTime.hour.toString().padLeft(2, '0');
                            ownerHomeController.eSlots[1] = "$hour:00";
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
                                ownerHomeController.eSlots[1],
                                style: TextStyle(
                                    color: authController.isDarkMode.value
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
              SizedBox(
                height: getH(context) * 0.03,
              ),
              Obx(
                () => submitBtn(
                    context,
                    ownerHomeController.isLoading.value
                        ? "Please wait..."
                        : "Update slots", () {
                  if (ownerHomeController.editDays.isEmpty ||
                      ownerHomeController.mSlots.isEmpty ||
                      ownerHomeController.eSlots.isEmpty) {
                    showErrorSnackBar(
                        heading: "Empty slots",
                        message: "Please enter slots",
                        icon: Icons.error);
                  } else {
                    ownerHomeController.editgymSlots();
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
