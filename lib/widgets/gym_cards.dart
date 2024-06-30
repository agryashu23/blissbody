import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GymCards extends StatefulWidget {
  const GymCards({
    super.key,
    required this.item,
  });

  final Map<String, dynamic> item;

  @override
  State<GymCards> createState() => _GymCardsState();
}

class _GymCardsState extends State<GymCards> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/details', arguments: widget.item);
      },
      child: Obx(
        () => Card(
          margin: const EdgeInsets.only(top: 0),
          elevation: 0,
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
                      widget.item["images"][0].toString(), 80,
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
                          child: Text(
                            widget.item["name"].toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: authController.isDarkMode.value
                                    ? Colors.white
                                    : ColorConst.titleColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              profileController.favourites.removeWhere(
                                  (gym) => gym['_id'] == widget.item['_id']);
                              profileController
                                  .toggleFavourite(widget.item['_id']);
                            },
                            child: Icon(
                              Icons.delete,
                              color: authController.isDarkMode.value
                                  ? Colors.white
                                  : ColorConst.titleColor,
                            ))
                      ],
                    ),
                    SizedBox(
                      width: getW(context) * 0.5,
                      child: Text(
                          "${widget.item["address"]},${widget.item["city"]}",
                          style: const TextStyle(
                              fontSize: 12,
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
                          profileController
                              .calculateAverage(widget.item['reviews'])
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
                          '${widget.item['opening_time'] ?? ""}-${widget.item['closing_time'] ?? ""}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: ColorConst.titleColor,
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
