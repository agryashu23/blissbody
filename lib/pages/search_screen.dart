import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchCity extends StatelessWidget {
  SearchCity({super.key});

  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        body: MainPage(
          child: SingleChildScrollView(
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
                      child: TextFormField(
                        controller: homeController.searchCityController,
                        onChanged: homeController.fetchSuggestions,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25)),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          hintText: "Search city",
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
                const Divider(
                  color: ColorConst.primaryGrey,
                ),
                GestureDetector(
                  onTap: () async {
                    await homeController.getLocation();
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.navigation),
                        Text(
                          "Use Current Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: ColorConst.primaryGrey,
                ),
                Obx(
                  () => SizedBox(
                    height: getH(context) * 0.7,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: homeController.cities.length,
                      itemBuilder: (context, index) {
                        final title = homeController.cities[index];
                        return GestureDetector(
                          onTap: () async {
                            homeController.currentCity.value = title;
                            await homeController.getGyms();
                            Get.back();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                dense: true,
                                leading: const Icon(Icons.location_on),
                                title: Text(
                                  title.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      color: ColorConst.titleColor),
                                ),
                              ),
                              const Divider(
                                color: ColorConst.primaryGrey,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
