import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/adminController.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final AuthController authController = Get.find<AuthController>();
  final AdminController adminController = Get.find<AdminController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      adminController.getUsersLength();
      adminController.getGymsLength();
      adminController.getReelsLength();
      adminController.getBookingsLength();
      adminController.getTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DASHBOARD",
          style: TextStyle(
            fontSize: 17,
            color: ColorConst.titleColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        width: getW(context) * 0.7,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: getH(context) * 0.1),
            ListTile(
                leading: Icon(
                  Icons.book_online,
                  color: authController.isDarkMode.value
                      ? Colors.white
                      : ColorConst.titleColor,
                ),
                title: Text(
                  'Bookings',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: authController.isDarkMode.value
                          ? Colors.white
                          : ColorConst.titleColor,
                      fontSize: 17),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed('/admin/bookings');
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
              child: const Divider(
                height: 8,
                color: ColorConst.borderColor,
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.payment,
                  color: authController.isDarkMode.value
                      ? Colors.white
                      : ColorConst.titleColor,
                ),
                title: Text(
                  'Transactions',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: authController.isDarkMode.value
                          ? Colors.white
                          : ColorConst.titleColor,
                      fontSize: 17),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  Get.toNamed('/admin/transactions');
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
              child: const Divider(
                height: 8,
                color: ColorConst.borderColor,
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.book_online,
                  color: authController.isDarkMode.value
                      ? Colors.white
                      : ColorConst.titleColor,
                ),
                title: Text(
                  'All Gyms',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: authController.isDarkMode.value
                          ? Colors.white
                          : ColorConst.titleColor,
                      fontSize: 17),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  Get.toNamed('/admin/gyms');
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
              child: const Divider(
                height: 8,
                color: ColorConst.borderColor,
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.edit_note,
                  color: authController.isDarkMode.value
                      ? Colors.white
                      : ColorConst.titleColor,
                ),
                title: Text(
                  'Add gym',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: authController.isDarkMode.value
                          ? Colors.white
                          : ColorConst.titleColor,
                      fontSize: 17),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  Get.toNamed('/admin/add-gym');
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
              child: const Divider(
                height: 8,
                color: ColorConst.borderColor,
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.fitness_center,
                  color: authController.isDarkMode.value
                      ? Colors.white
                      : ColorConst.titleColor,
                ),
                title: Text(
                  'Your gyms',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: authController.isDarkMode.value
                          ? Colors.white
                          : ColorConst.titleColor,
                      fontSize: 17),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  Get.toNamed('/admin/own/gyms');
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
              child: const Divider(
                height: 8,
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
                  Navigator.pop(context);
                  Get.offAllNamed('/login');
                }),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: getH(context) * 0.01,
                horizontal: getW(context) * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showErrorSnackBar(
                        heading: "Users",
                        message:
                            "Total numberof active users are ${adminController.usersLength.value.toString()} ",
                        icon: Icons.person);
                  },
                  child: Card(
                    elevation: 3,
                    color: Colors.grey.shade100,
                    surfaceTintColor: Colors.grey.shade100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.07,
                          vertical: getH(context) * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Total Users",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.3,
                                color: ColorConst.primaryGrey,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Obx(
                            () => Text(
                              adminController.usersLength.value.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 0.3,
                                  color: ColorConst.titleColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/admin/gyms');
                  },
                  child: Card(
                    elevation: 3,
                    color: Colors.grey.shade100,
                    surfaceTintColor: Colors.grey.shade100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.07,
                          vertical: getH(context) * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Total Gyms",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.3,
                                color: ColorConst.primaryGrey,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Obx(
                            () => Text(
                              adminController.gymsLength.value.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 0.3,
                                  color: ColorConst.titleColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: getH(context) * 0.02,
          ),
          GestureDetector(
            onTap: () {
              showErrorSnackBar(
                  heading: "Reels",
                  message:
                      "Total number of reels made are ${adminController.reelsLength.value.toString()}",
                  icon: Icons.tiktok);
            },
            child: Card(
              elevation: 3,
              color: Colors.grey.shade100,
              surfaceTintColor: Colors.grey.shade100,
              child: Container(
                width: getW(context) * 0.85,
                padding: EdgeInsets.symmetric(
                    horizontal: getW(context) * 0.12,
                    vertical: getH(context) * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Total Reels",
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          color: ColorConst.primaryGrey,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Obx(
                      () => Text(
                        adminController.reelsLength.value.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            letterSpacing: 0.3,
                            color: ColorConst.titleColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: getH(context) * 0.02,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: getH(context) * 0.01,
                horizontal: getW(context) * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/admin/bookings');
                  },
                  child: Card(
                    elevation: 3,
                    color: Colors.grey.shade100,
                    surfaceTintColor: Colors.grey.shade100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.03,
                          vertical: getH(context) * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Total Bookings",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.3,
                                color: ColorConst.primaryGrey,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Obx(
                            () => Text(
                              adminController.bookingsLength.value.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 0.3,
                                  color: ColorConst.titleColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/admin/transactions');
                  },
                  child: Card(
                    elevation: 3,
                    color: Colors.grey.shade100,
                    surfaceTintColor: Colors.grey.shade100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.06,
                          vertical: getH(context) * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Transactions",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.3,
                                color: ColorConst.primaryGrey,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Obx(
                            () => Text(
                              "₹" + adminController.totalPrice.value.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 0.3,
                                  color: ColorConst.titleColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
