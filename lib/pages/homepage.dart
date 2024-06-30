import 'package:blissbody_app/controllers/detailController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/controllers/reelsController.dart';
import 'package:blissbody_app/widgets/booking_card.dart';
import 'package:blissbody_app/widgets/nearby_gym.dart';
import 'package:blissbody_app/widgets/transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/helper/help_widgets.dart';

import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.find<HomeController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final ReelsController reelsController = Get.find<ReelsController>();
  final DetailController detailController = Get.find<DetailController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileController.getProfile();
      await detailController.getBooking();
      await reelsController.getReels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(
            () => Container(
              padding: EdgeInsets.only(
                top: getH(context) * 0.035,
                left: getH(context) * 0.015,
                right: getH(context) * 0.015,
              ),
              height: getH(context) * 0.31,
              decoration: BoxDecoration(
                  color: authController.isDarkMode.value
                      ? ColorConst.websiteHomeBox
                      : ColorConst.websiteHomeBox.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: getW(context) * 0.07),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: homeController.openDrawer,
                          child: Image.asset(
                            "assets/icons/menu.png",
                            color: Colors.white,
                            width: 25,
                            height: 25,
                          ),
                        ),
                        SizedBox(
                          width: getW(context) * 0.04,
                        ),
                        Obx(
                          () => CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: profileController.imageUrl.isEmpty
                                ? CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 16,
                                    child: Center(
                                      child: Icon(Icons.person,
                                          color: Colors.white,
                                          size: getW(context) * 0.08),
                                    ))
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        profileController.imageUrl.value),
                                    radius: 16,
                                  ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            homeController.fetchSuggestions("");
                            Get.toNamed('/search-city');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                                color: Colors.white,
                              ),
                              Obx(
                                () => Text(
                                  homeController.currentCity.value,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getW(context) * 0.04, top: 6),
                    child: Text(
                      "Hello ${homeController.getGreetingMessage()}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: getW(context) * 0.03, top: 2),
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
                      SizedBox(
                        width: 16,
                      ),
                      Obx(
                        () => profileController.height.value.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Height",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        profileController.height.value,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        profileController.heightdim.value
                                            ? " (in)"
                                            : " (cm)",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Obx(
                        () => profileController.weight.value.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Weight",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        profileController.weight.value,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        profileController.weightdim.value
                                            ? " (kg)"
                                            : " (lbs)",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getW(context) * 0.04,
                  ),
                  TextFormField(
                    controller: homeController.searchController,
                    onChanged: (value) {
                      homeController.searchValue.value = value;
                    },
                    readOnly: true,
                    onTap: () {
                      Get.toNamed('/search/gyms');
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      hintText: "Search",
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
                ],
              ),
            ),
          ),
          SizedBox(height: getH(context) * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nearby Gym",
                  style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.3,
                      color: ColorConst.titleColor,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/nearby/gyms');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Explore more",
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConst.primaryGrey,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt_outlined,
                        size: 18,
                        color: ColorConst.primaryGrey,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => homeController.isLoading.value
                ? const CircularProgressIndicator()
                : homeController.gyms.isEmpty
                    ? Container(
                        height: getH(context) * 0.1,
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fitness_center_outlined,
                              color: ColorConst.primaryGrey,
                              size: 18,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "No gyms found",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConst.primaryGrey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: homeController.gyms.length == 1
                            ? getH(context) * 0.18
                            : homeController.gyms.length == 2
                                ? getH(context) * 0.34
                                : getH(context) * 0.53,
                        child: ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 5, left: 2, right: 2),
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeController.gyms.length > 3
                                ? 3
                                : homeController.gyms.length,
                            itemBuilder: (BuildContext context, int i) {
                              return NearbyGym(item: homeController.gyms[i]);
                            }),
                      ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recent booking",
                  style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.3,
                      color: ColorConst.titleColor,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/bookings');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConst.primaryGrey,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt_outlined,
                        size: 18,
                        color: ColorConst.primaryGrey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => detailController.isLoading.value
                ? const CircularProgressIndicator()
                : detailController.booking.isEmpty
                    ? Container(
                        height: getH(context) * 0.1,
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fitness_center_outlined,
                              color: ColorConst.primaryGrey,
                              size: 18,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "No Booking found",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConst.primaryGrey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: detailController.booking.length == 1
                            ? getH(context) * 0.24
                            : getH(context) * 0.48,
                        child: ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 0, left: 2, right: 2),
                            itemCount: detailController.booking.length > 2
                                ? 2
                                : detailController.booking.length,
                            itemBuilder: (context, index) {
                              return BookingCard(
                                  item: detailController.booking[index]);
                            })),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
