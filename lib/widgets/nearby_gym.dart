import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/constants/images.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NearbyGym extends StatelessWidget {
  NearbyGym({super.key, required this.item});
  final Map<String, dynamic> item;

  final HomeController homeController = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final OwnerHomeController ownerHomeController =
      Get.find<OwnerHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () async {
          ownerHomeController.latitude.value = 0.0;
          ownerHomeController.longitude.value = 0.0;
          await ownerHomeController.getGymReviews(item["_id"]);
          Get.toNamed('/details', arguments: item);
        },
        child: Card(
          margin: const EdgeInsets.only(top: 2, left: 2, right: 2),
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    authController.isDarkMode.value
                        ? ColorConst.dividerLine
                        : Colors.white,
                    authController.isDarkMode.value
                        ? ColorConst.dark
                        : Colors.grey.shade100,
                  ]),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: commonCacheImageWidget(
                      item['images'].isEmpty
                          ? onboard1Image
                          : item["images"][0].toString(),
                      80,
                      width: getW(context) * 0.25,
                      fit: BoxFit.cover),
                ),
                SizedBox(
                  width: getW(context) * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: getW(context) * 0.57,
                          child: Obx(
                            () => Text(
                              item["name"].toString(),
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                  color: authController.isDarkMode.value
                                      ? Colors.white
                                      : ColorConst.titleColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              if (profileController.favourites
                                  .contains(item['_id'])) {
                                profileController.favourites
                                    .remove(item['_id']);
                              } else {
                                profileController.favourites.add(item['_id']);
                              }
                              profileController.toggleFavourite(item['_id']);
                            },
                            child: Obx(() => profileController.favourites
                                    .contains(item['_id'])
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: ColorConst.primaryGrey,
                                  )))
                      ],
                    ),
                    SizedBox(
                      width: getW(context) * 0.5,
                      child: Text("${item["address"]},${item["city"]}",
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              color: ColorConst.primaryGrey,
                              fontWeight: FontWeight.w500)),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: ColorConst.websiteHomeBox,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          ownerHomeController
                              .calculateAverage(item['reviews'])
                              .toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: authController.isDarkMode.value
                                  ? ColorConst.primaryGrey
                                  : ColorConst.titleColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.lock_clock,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${item['opening_time']}-${item['closing_time']}",
                          style: TextStyle(
                              fontSize: 14,
                              color: authController.isDarkMode.value
                                  ? ColorConst.primaryGrey
                                  : ColorConst.titleColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: getW(context) * 0.1,
                        ),
                        const Text(
                          "DETAILS",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1.2,
                              color: ColorConst.primaryGrey,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 14,
                          color: ColorConst.primaryGrey,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
