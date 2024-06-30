import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/controllers/reelsController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/owner_pages/owner_homepage.dart';
import 'package:blissbody_app/pages/mainpage.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController authController = Get.find<AuthController>();

  final ProfileController profileController = Get.find<ProfileController>();
  final ReelsController reelsController = Get.find<ReelsController>();
  final OwnerHomeController ownerHomeController =
      Get.find<OwnerHomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        body: ownerHomeController.isLoadingSwitch.value
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: ColorConst.websiteHomeBox,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Switching to Owner Profile",
                      style: TextStyle(
                          color: ColorConst.titleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            : profileController.isOwner.value
                ? const OwnerHomePage()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: getH(context) * 0.06),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: getW(context) * 0.065,
                            ),
                            const Text(
                              "PROFILE",
                              style: TextStyle(
                                  color: ColorConst.titleColor,
                                  letterSpacing: 2,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/edit-profile');
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.edit_note_outlined,
                                  color: authController.isDarkMode.value
                                      ? Colors.white
                                      : ColorConst.titleColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getH(context) * 0.023,
                        ),
                        Obx(() => profileController.imageUrl.isEmpty
                            ? CircleAvatar(
                                backgroundColor: ColorConst.titleColor,
                                radius: 50,
                                child: Center(
                                  child: Icon(Icons.person,
                                      color: Colors.white,
                                      size: getW(context) * 0.2),
                                ))
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                    profileController.imageUrl.value),
                                radius: 50,
                              )),
                        Container(
                          margin: EdgeInsets.only(top: getH(context) * 0.015),
                          child: Text(
                            profileController.nameController.text,
                            style: const TextStyle(
                                color: ColorConst.titleColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: getH(context) * 0.006,
                              left: getW(context) * 0.1,
                              right: getW(context) * 0.1),
                          child: Card(
                            surfaceTintColor: authController.isDarkMode.value
                                ? ColorConst.dark
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 2,
                            color: authController.isDarkMode.value
                                ? ColorConst.dark
                                : Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getW(context) * 0.04,
                                  vertical: getH(context) * 0.018),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => heightWidget(
                                        profileController.heightdim.value
                                            ? "Height (in)"
                                            : "Height (cm)",
                                        profileController.height.value),
                                  ),
                                  verticalDivider(context),
                                  Obx(
                                    () => heightWidget(
                                        profileController.weightdim.value
                                            ? "Weight (kg)"
                                            : "Weight (lbs)",
                                        profileController.weight.value),
                                  ),
                                  verticalDivider(context),
                                  Obx(
                                    () => heightWidget("Age (years)",
                                        profileController.age.value),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getH(context) * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                authController.isDarkMode.value
                                    ? "Dark mode"
                                    : "Light mode",
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
                                  value: authController.isDarkMode.value,
                                  onChanged: (value) {
                                    authController.isDarkMode.value = value;
                                  },
                                  activeTrackColor: ColorConst
                                      .websiteHomeBox, // Color for the track when on
                                  activeColor: Colors
                                      .white, // Color for the thumb when on
                                  inactiveTrackColor: ColorConst
                                      .primaryGrey, // Color for the track when off
                                  inactiveThumbColor: Colors
                                      .white, // Color for the thumb when off
                                  // You can add more customizations as needed
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getH(context) * 0.01),
                        GestureDetector(
                          onTap: () async {
                            await reelsController.getUserReel();
                            Get.toNamed('/user/reel');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getW(context) * 0.05,
                                vertical: getH(context) * 0.002),
                            child: profileTiles(
                                context,
                                Icons.tiktok,
                                "My Reels",
                                "Dive into your creations that you have created "),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getW(context) * 0.15, right: 20),
                          child: const Divider(
                            color: ColorConst.borderColor,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.toNamed('/bookings');
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: getW(context) * 0.05,
                        //         vertical: getH(context) * 0.002),
                        //     child: profileTiles(
                        //         context,
                        //         Icons.book_online,
                        //         "Bookings",
                        //         "Dive into your creations that you have created "),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: getW(context) * 0.15, right: 20),
                        //   child: const Divider(
                        //     color: ColorConst.borderColor,
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.toNamed('/transactions');
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: getW(context) * 0.05,
                        //         vertical: getH(context) * 0.002),
                        //     child: profileTiles(
                        //         context,
                        //         Icons.payment,
                        //         "Payment Transactions",
                        //         "Dive into your creations that you have created "),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: getW(context) * 0.15, right: 20),
                        //   child: const Divider(
                        //     color: ColorConst.borderColor,
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            // await profileController.getFavourite();
                            Get.toNamed('/favourites');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getW(context) * 0.05,
                                vertical: getH(context) * 0.002),
                            child: profileTiles(
                                context,
                                Icons.favorite_border_outlined,
                                "Favourites",
                                "Dive into your creations that you have created "),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getW(context) * 0.15, right: 20),
                          child: const Divider(
                            color: ColorConst.borderColor,
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const Text(
                        //       "Switch to owner",
                        //       style: TextStyle(
                        //           color: ColorConst.titleColor,
                        //           letterSpacing: 0.3,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w500),
                        //     ),
                        //     const SizedBox(
                        //       width: 8,
                        //     ),
                        //     Obx(
                        //       () => Transform.scale(
                        //         scale: 0.9,
                        //         child: Switch(
                        //           value: profileController.isOwner.value,
                        //           onChanged: (value) async {
                        //             if (profileController.isOwner.value ==
                        //                 false) {
                        //               await ownerHomeController
                        //                   .getOwnerProfile();
                        //             }

                        //             profileController.isOwner.value = value;
                        //           },
                        //           activeTrackColor: ColorConst
                        //               .websiteHomeBox, // Color for the track when on
                        //           activeColor: Colors
                        //               .white, // Color for the thumb when on
                        //           inactiveTrackColor: ColorConst
                        //               .primaryGrey, // Color for the track when off
                        //           inactiveThumbColor: Colors
                        //               .white, // Color for the thumb when off
                        //           // You can add more customizations as needed
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
      ),
    );
  }
}
