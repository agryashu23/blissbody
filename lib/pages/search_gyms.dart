import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/nearby_gym.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchGyms extends StatelessWidget {
  SearchGyms({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: getW(context) * 0.15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: getW(context) * 0.02,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back)),
                  SizedBox(width: getW(context) * 0.05),
                  SizedBox(
                    width: getW(context) * 0.8,
                    child: TextField(
                      controller: homeController.searchGymController,
                      onChanged: homeController.searchGyms,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: ColorConst.borderColor),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: ColorConst.borderColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: ColorConst.borderColor),
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        hintText: "Enter gym name",
                        hintStyle: const TextStyle(
                          fontSize: 17,
                          color: ColorConst.primaryGrey,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                        prefixIconColor: ColorConst.primaryGrey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getH(context) * 0.05),
              Obx(
                () => homeController.isLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: getH(context) * 0.4),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : homeController.searchGymValues.isEmpty
                        ? Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: getH(context) * 0.4),
                              child:
                                  const Text("No Gyms found with this name."),
                            ),
                          )
                        : SizedBox(
                            height: getH(context) * 0.7,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: homeController.searchGymValues.length,
                              itemBuilder: (context, index) {
                                return NearbyGym(
                                    item:
                                        homeController.searchGymValues[index]);
                              },
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
