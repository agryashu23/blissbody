import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/adminController.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/models/image_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NearbyGym2 extends StatelessWidget {
  NearbyGym2({super.key, required this.item});
  final Map<String, dynamic> item;

  final AuthController authController = Get.find<AuthController>();
  final AdminController adminController = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        adminController.nameController.text = item['name'] ?? "";
        adminController.cityController.text = item['city'] ?? "";
        adminController.locationController.text = item['address'] ?? "";
        adminController.openingTime.value = item['opening_time'] ?? "";
        adminController.closingTime.value = item['clsoing_time'] ?? "";
        adminController.selectedGender.value = item['gender'] ?? 0;
        adminController.editabout.value = item['about'] ?? "";
        adminController.editReviews.value = item['reviews'] ?? [];
        adminController.editAmenities.value = item['amenities'] ?? [];
        adminController.editMachines.value = item['machines'] ?? [];
        adminController.hourPackage.value = item['hour_package'] ?? [];
        adminController.editDays.value = item['days'];
        if (item['hour_package'].isNotEmpty) {
          adminController.hourController.text = item['hour_package'][1] ?? "";
        }
        if (item['morning_time'].isNotEmpty) {
          adminController.mSlots[0] = item['morning_time'][0];
          adminController.mSlots[1] = item['morning_time'][1];
        }
        if (item['evening_time'].isNotEmpty) {
          adminController.eSlots[0] = item['evening_time'][0];
          adminController.eSlots[1] = item['evening_time'][1];
        }
        if (item['packages'].isNotEmpty) {
          adminController.month1Controller.text =
              item['packages'][0]['price'] ?? "";
          adminController.month3Controller.text =
              item['packages'][1]['price'] ?? "";
          adminController.month6Controller.text =
              item['packages'][2]['price'] ?? "";
          adminController.yearController.text =
              item['packages'][3]['price'] ?? "";
        }
        adminController.images = <ImageItem>[].obs;
        adminController.imageNetworks.value = item['images'] ?? [];
        if (item['images'] != null && item['images'].isNotEmpty) {
          for (var x in item['images']) {
            adminController.images.add(ImageItem(imageUrl: x));
          }
        }
        Get.toNamed('/admin/edit-gym', arguments: item['_id']);
      },
      child: Card(
        margin: const EdgeInsets.only(top: 0),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                child: commonCacheImageWidget(item["images"][0].toString(), 80,
                    width: getW(context) * 0.25, fit: BoxFit.cover),
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
                        width: getW(context) * 0.6,
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
                        adminController
                            .calculateAverage(item['reviews'])
                            .toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: ColorConst.titleColor,
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
                        style: const TextStyle(
                            fontSize: 14,
                            color: ColorConst.titleColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: getW(context) * 0.1,
                      ),
                      const Text(
                        "EDIT",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.5,
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
    );
  }
}
