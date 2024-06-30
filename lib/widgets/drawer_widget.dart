import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:
          authController.isDarkMode.value ? Colors.black : Colors.white,
      width: getW(context) * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: ColorConst.websiteHomeBox,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: profileController.imageUrl.isEmpty
                            ? CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 38,
                                child: Center(
                                  child: Icon(Icons.person,
                                      color: Colors.white,
                                      size: getW(context) * 0.08),
                                ))
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                    profileController.imageUrl.value),
                                radius: 38,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Obx(
                        () => Text(
                          profileController.nameValue.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          ListTile(
              leading: Icon(
                Icons.edit,
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
              ),
              title: Text(
                'Edit profile',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: authController.isDarkMode.value
                        ? Colors.white
                        : ColorConst.titleColor,
                    fontSize: 17),
              ),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/edit-profile');
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
            child: const Divider(
              height: 4,
              color: ColorConst.borderColor,
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.favorite,
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
              ),
              title: Text(
                'Favourites',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: authController.isDarkMode.value
                        ? Colors.white
                        : ColorConst.titleColor,
                    fontSize: 17),
              ),
              onTap: () async {
                await profileController.getFavourite();
                Navigator.pop(context);
                Get.toNamed('/favourites');
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
            child: const Divider(
              height: 4,
              color: ColorConst.borderColor,
            ),
          ),
          // ListTile(
          //     leading: Icon(
          //       Icons.book_online,
          //       color: authController.isDarkMode.value
          //           ? Colors.white
          //           : ColorConst.titleColor,
          //     ),
          //     title: Text(
          //       'Bookings',
          //       style: TextStyle(
          //           fontWeight: FontWeight.w500,
          //           color: authController.isDarkMode.value
          //               ? Colors.white
          //               : ColorConst.titleColor,
          //           fontSize: 17),
          //     ),
          //     onTap: () async {
          //       Navigator.pop(context);
          //       Get.toNamed('/bookings');
          //     }),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
          //   child: const Divider(
          //     height: 4,
          //     color: ColorConst.borderColor,
          //   ),
          // ),
          ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
              ),
              title: Text(
                'Privacy Policy',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: authController.isDarkMode.value
                        ? Colors.white
                        : ColorConst.titleColor,
                    fontSize: 17),
              ),
              onTap: () async {
                Navigator.pop(context);
                Get.toNamed('/privacy');
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
            child: const Divider(
              height: 4,
              color: ColorConst.borderColor,
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Sign out',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                    fontSize: 17),
              ),
              onTap: () async {
                await authController.logout();
                profileController.nameController.clear();
                profileController.ageController.clear();
                Navigator.pop(context);
                Get.offAllNamed('/login');
              }),
        ],
      ),
    );
  }
}
