import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/owner_pages/widgets/packageCard.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerEditPackage extends StatelessWidget {
  OwnerEditPackage({super.key});

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
          title: Text(
            "EDIT PACKAGES",
            style: TextStyle(
              fontSize: 17,
              letterSpacing: 1.2,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
            ),
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
          backgroundColor:
              authController.isDarkMode.value ? Colors.black : Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: getH(context) * 0.01),
                  child:
                      labelName(context, "Create hourly package (Optional)")),
              packageCard(
                  context, ownerHomeController.hourController, "1 Hour"),
              Container(
                  margin: EdgeInsets.only(top: getH(context) * 0.02),
                  child: labelName(context, "Create monthly package")),
              packageCard(
                  context, ownerHomeController.month1Controller, "1 Month"),
              packageCard(
                  context, ownerHomeController.month3Controller, "3 Months"),
              packageCard(
                  context, ownerHomeController.month6Controller, "6 Months"),
              packageCard(
                  context, ownerHomeController.yearController, "1 Year"),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              Obx(
                () => submitBtn(
                    context,
                    ownerHomeController.isLoading.value
                        ? "Please wait..."
                        : "Update", () {
                  if (ownerHomeController.month1Controller.text.isEmpty ||
                      ownerHomeController.month3Controller.text.isEmpty ||
                      ownerHomeController.month6Controller.text.isEmpty ||
                      ownerHomeController.yearController.text.isEmpty) {
                    showErrorSnackBar(
                        heading: "Empty",
                        message: "Please fill all monthly packages",
                        icon: Icons.error);
                  } else {
                    var hours = [
                      "1 Hour",
                      ownerHomeController.hourController.text
                    ];
                    var packages = [
                      {
                        "name": "1 Month",
                        "price": ownerHomeController.month1Controller.text
                      },
                      {
                        "name": "3 Months",
                        "price": ownerHomeController.month3Controller.text
                      },
                      {
                        "name": "6 Months",
                        "price": ownerHomeController.month6Controller.text
                      },
                      {
                        "name": "1 Year",
                        "price": ownerHomeController.yearController.text
                      },
                    ].obs;
                    ownerHomeController.editgymPackages(hours, packages);
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
