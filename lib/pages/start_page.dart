import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/pages/homepage.dart';
import 'package:blissbody_app/pages/plans.dart';
import 'package:blissbody_app/pages/profile_page.dart';
import 'package:blissbody_app/pages/reels.dart';
import 'package:blissbody_app/widgets/chooseVideo.dart';
import 'package:blissbody_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final HomeController homeController = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  final List<Widget> widgetOptions = [
    const HomePage(),
    const Reels(),
    Plans(),
    const ProfilePage()
  ];
  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.tiktok),
      label: 'Reels',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.fitness_center),
      label: 'Plans',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        key: homeController.scaffoldKey,
        drawer: DrawerWidget(),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 2,
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              authController.isDarkMode.value ? Colors.black : Colors.white,
          items: bottomNavItems,
          unselectedItemColor: ColorConst.primaryGrey,
          unselectedLabelStyle: const TextStyle(color: ColorConst.primaryGrey),
          currentIndex: homeController.selectedIndex.value,
          selectedItemColor: ColorConst.websiteHomeBox,
          onTap: homeController.onTapped,
        ),
        body: widgetOptions[homeController.selectedIndex.value],
      ),
    );
  }
}
