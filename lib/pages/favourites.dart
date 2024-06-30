import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/widgets/gym_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final HomeController homeController = Get.find<HomeController>();

  final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    profileController.getFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text(
            "FAVOURITES",
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
        body: Obx(
          () => profileController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : profileController.favourites.isEmpty
                  ? Center(
                      child: Text(
                        "You have not added anything to favourites.",
                        style: TextStyle(
                          color: authController.isDarkMode.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      shrinkWrap: true,
                      itemCount: profileController.favourites.length,
                      itemBuilder: (BuildContext context, int i) {
                        return GymCards(
                          item: profileController.favourites[i],
                        );
                      }),
        ),
      ),
    );
  }
}
