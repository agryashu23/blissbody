import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/constants/images.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/ownerdetailController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../helper/help_widgets.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  final OwnerHomeController ownerHomeController =
      Get.find<OwnerHomeController>();
  final OwnerDetailController ownerDetailController =
      Get.find<OwnerDetailController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Image.asset(
            onboard1Image,
            width: double.infinity,
            height: getH(context) * 0.1,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getH(context) * 0.03,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black38),
                  child: Column(
                    children: [
                      const Text(
                        "Manage Gym",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: getH(context) * 0.005),
                      const Text(
                        "Manage your gym details through this portal",
                        style: TextStyle(
                            color: ColorConst.primaryGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getH(context) * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        ownerHomeController.isActive.value
                            ? "Gym Online"
                            : "Gym offline",
                        style: const TextStyle(
                            color: ColorConst.titleColor,
                            letterSpacing: 0.3,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Obx(
                      () => Transform.scale(
                        scale: 0.9,
                        child: Switch(
                          value: ownerHomeController.isActive.value,
                          onChanged: (value) {
                            ownerHomeController.isActive.value = value;
                            ownerHomeController.toggleActive();
                          },
                          activeTrackColor: ColorConst.websiteHomeBox,
                          activeColor: Colors.white,
                          inactiveTrackColor: ColorConst.primaryGrey,
                          inactiveThumbColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getH(context) * 0.01),
                GestureDetector(
                  onTap: () {
                    ownerDetailController.latitude.value = 0.0;
                    ownerDetailController.longitude.value = 0.0;
                    ownerHomeController.buildChildrenWidgets();
                    ownerHomeController.calculateRatingStatistics();
                    if (ownerHomeController.nameController.text.isEmpty) {
                      showErrorSnackBar(
                          heading: "Processing..",
                          message: "Edit gym details...",
                          icon: Icons.abc);
                    } else {
                      ownerHomeController.editReviews.length;
                      Get.toNamed('/owner/profile');
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getW(context) * 0.05,
                        vertical: getH(context) * 0.006),
                    child: ownerTiles(
                        context,
                        Icons.person,
                        "View your profile",
                        "View the way your users see your gym profile"),
                  ),
                ),
                // Padding(
                //   padding:
                //       EdgeInsets.only(left: getW(context) * 0.15, right: 20),
                //   child: const Divider(
                //     color: ColorConst.borderColor,
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Get.toNamed("/owner/edit/profile");
                //   },
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //         horizontal: getW(context) * 0.05,
                //         vertical: getH(context) * 0.006),
                //     child: ownerTiles(
                //         context,
                //         Icons.edit_document,
                //         "Edit gym profile (Mandatory)",
                //         "Edit profile for your gym."),
                //   ),
                // ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getW(context) * 0.15, right: 20),
                  child: const Divider(
                    color: ColorConst.borderColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/owner/edit/details");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getW(context) * 0.05,
                        vertical: getH(context) * 0.006),
                    child: ownerTiles(context, Icons.edit_document,
                        "Edit gym details", "Edit your details for your gym."),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getW(context) * 0.15, right: 20),
                  child: const Divider(
                    color: ColorConst.borderColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/owner/edit/cover');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getW(context) * 0.05,
                        vertical: getH(context) * 0.006),
                    child: ownerTiles(
                        context,
                        Icons.photo_album,
                        "Edit cover images",
                        "Edit your cover images and videos for gym."),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getW(context) * 0.15, right: 20),
                  child: const Divider(
                    color: ColorConst.borderColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/owner/edit/slots');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getW(context) * 0.05,
                        vertical: getH(context) * 0.006),
                    child: ownerTiles(
                        context,
                        Icons.timer_rounded,
                        "Manage your slots",
                        "Manage the date and time of gym."),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getW(context) * 0.15, right: 20),
                  child: const Divider(
                    color: ColorConst.borderColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/owner/bookings');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getW(context) * 0.05,
                        vertical: getH(context) * 0.006),
                    child: ownerTiles(
                        context,
                        Icons.book_online,
                        "Manage your bookings",
                        "Manage your overall gym bookings."),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getW(context) * 0.15, right: 20),
                  child: const Divider(
                    color: ColorConst.borderColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/owner/transactions');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getW(context) * 0.05,
                        vertical: getH(context) * 0.006),
                    child: ownerTiles(
                        context,
                        Icons.payment,
                        "Payment Transactions",
                        "Analyse the transaction on your gym."),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getW(context) * 0.15, right: 20),
                  child: const Divider(
                    color: ColorConst.borderColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/owner/edit/package');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getW(context) * 0.05,
                        vertical: getH(context) * 0.006),
                    child: ownerTiles(
                        context,
                        Icons.task,
                        "Manage your packages",
                        "Manage the packages for your gym."),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: getW(context) * 0.15, right: 20),
                  child: const Divider(
                    color: ColorConst.borderColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/owner/edit/machines');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getW(context) * 0.05,
                        vertical: getH(context) * 0.006),
                    child: ownerTiles(
                        context,
                        Icons.fitness_center,
                        "Manage your machines",
                        "Manage the machines for your gym."),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        profileController.isOwner.value
                            ? "Switch to user"
                            : "Switch to owner",
                        style: const TextStyle(
                            color: ColorConst.titleColor,
                            letterSpacing: 0.3,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Obx(
                      () => Transform.scale(
                        scale: 0.9,
                        child: Switch(
                          value: profileController.isOwner.value,
                          onChanged: (value) {
                            profileController.isOwner.value = value;
                          },
                          activeTrackColor: ColorConst.websiteHomeBox,
                          activeColor: Colors.white,
                          inactiveTrackColor: ColorConst.primaryGrey,
                          inactiveThumbColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
