import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerMachines extends StatelessWidget {
  OwnerMachines({super.key});

  final OwnerHomeController ownerHomeController =
      Get.find<OwnerHomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            "EDIT MACHINES",
            style: TextStyle(
              fontSize: 17,
              letterSpacing: 1.2,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
            ),
          ),
          centerTitle: true,
          backgroundColor:
              authController.isDarkMode.value ? Colors.black : Colors.white,
          elevation: 0,
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
        body: Container(
          color: authController.isDarkMode.value ? Colors.black : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: getH(context) * 0.01,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: machines.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => CheckboxListTile(
                        title: Text(
                          machines[index],
                          style: TextStyle(
                            color: authController.isDarkMode.value
                                ? Colors.white
                                : ColorConst.titleColor,
                          ),
                        ),
                        dense: true,
                        activeColor: ColorConst.websiteHomeBox,
                        value: ownerHomeController.editMachines
                            .contains(machines[index]),
                        onChanged: (bool? newValue) {
                          if (ownerHomeController.editMachines
                              .contains(machines[index])) {
                            ownerHomeController.editMachines
                                .remove(machines[index]);
                          } else {
                            ownerHomeController.editMachines
                                .add(machines[index]);
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
                  child: Obx(
                () => submitBtn(
                    context,
                    ownerHomeController.isLoading.value
                        ? "Please wait..."
                        : "Update Machines", () {
                  if (ownerHomeController.editMachines.isEmpty) {
                    showErrorSnackBar(
                        heading: "Error",
                        message: "Add some machines",
                        icon: Icons.abc);
                  } else {
                    ownerHomeController.editgymDetails();
                  }
                }),
              )),
              SizedBox(
                height: getH(context) * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
