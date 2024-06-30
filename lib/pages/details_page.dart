import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/widgets/details_widget.dart';
import 'package:blissbody_app/widgets/reviews.dart';
import 'package:blissbody_app/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/helper/help_widgets.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  final CarouselController _carouselController = CarouselController();
  var item = Get.arguments as Map<String, dynamic>;

  final OwnerHomeController ownerHomeController =
      Get.find<OwnerHomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<Location> locations = await locationFromAddress(item['address']);
      ownerHomeController.latitude.value = locations[0].latitude;
      ownerHomeController.longitude.value = locations[0].longitude;
      ownerHomeController.calculateRatingStatistics();
    });
    buildChildrenWidgets();
    super.initState();
  }

  List<Widget> children = [];

  buildChildrenWidgets() {
    List<Widget> list = [];
    list.addAll(item['images']
        .map<Widget>((url) => Image.network(
              url,
              width: double.infinity,
              fit: BoxFit.cover,
            ))
        .toList());
    if (item['video'] != null && item['video'] != "") {
      list.add(VideoPlayerWidget(videoUrl: item['video']));
    }
    children.assignAll(list);
  }

  IconData getIconByName(String name) {
    if (name == "") {
      return Icons.add;
    }
    return amenityIcons[name] ?? Icons.error;
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        child: CarouselSlider(
                          items: children,
                          options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              aspectRatio: 1.5,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: getH(context) * 0.25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () =>
                                  _carouselController.animateToPage(entry.key),
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentIndex == entry.key
                                        ? ColorConst.websiteHomeBox
                                        : Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        padding: EdgeInsets.only(
                            top: getH(context) * 0.05, left: 10, right: 10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            item['phone'] != null && item['phone'] != ""
                                ? GestureDetector(
                                    onTap: () {
                                      makePhoneCall(item['phone']);
                                    },
                                    child: const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )
                                : const SizedBox()
                            // Icon(
                            //   Icons.edit_note_outlined,
                            //   color: Colors.white,
                            //   size: 28,
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.03),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.4,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ),
                      elevation: 3,
                      surfaceTintColor: authController.isDarkMode.value
                          ? Colors.grey.shade200
                          : Colors.white,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: getH(context) * 0.015,
                            bottom: getH(context) * 0.006),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getW(context) * 0.03,
                              ),
                              child: Text(
                                item['name'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConst.titleColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getW(context) * 0.03,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: ColorConst.primaryGrey,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: getW(context) * 0.82,
                                    child: Text(
                                      item['address'],
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConst.primaryGrey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: getH(context) * 0.01),
                              padding: EdgeInsets.symmetric(
                                horizontal: getW(context) * 0.02,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.timer_rounded,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '${item['opening_time'] ?? ""}-${item['closing_time'] ?? ""}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      item['gender'] == 0 || item['gender'] == 2
                                          ? const Icon(
                                              Icons.male,
                                              size: 20,
                                              color: Colors.blue,
                                            )
                                          : const SizedBox(),
                                      item['gender'] == 0 || item['gender'] == 2
                                          ? const Text(
                                              'Male',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ColorConst.primaryGrey),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      item['gender'] == 1 || item['gender'] == 2
                                          ? const Icon(
                                              Icons.female,
                                              size: 20,
                                              color: Colors.pink,
                                            )
                                          : const SizedBox(),
                                      item['gender'] == 1 || item['gender'] == 2
                                          ? const Text(
                                              'Female',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ColorConst.primaryGrey),
                                            )
                                          : const SizedBox(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            item['link'] != null && item['link'] != ""
                                ? GestureDetector(
                                    onTap: () async {
                                      await launchFunction(item['link']);
                                    },
                                    child: Container(
                                      width: getW(context) * 0.8,
                                      padding: const EdgeInsets.only(
                                          top: 4, left: 10),
                                      child: Text(
                                        item['link'],
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            Divider(
                              color: ColorConst.borderColor.withOpacity(0.4),
                              height: 8,
                            ),
                            // Other elements like time, location button, etc.
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getW(context) * 0.03,
                                  vertical: 7),
                              height: getH(context) * 0.065,
                              // Adjust based on your content
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: item['amenities'].length,
                                itemBuilder: (context, index) {
                                  var title = item['amenities'][index] ?? "";
                                  var icon = getIconByName(title);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getW(context) * 0.03),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          icon,
                                          color: ColorConst.dark,
                                          size: 16,
                                        ),
                                        Text(
                                          title,
                                          style: const TextStyle(
                                              color: ColorConst.primaryGrey,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  DetailsWidget(item: item),
                  ReviewsWidget(item: item),
                  SizedBox(
                    height: getH(context) * 0.2,
                  )
                ],
              ),
            ),
            // Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Padding(
            //         padding: const EdgeInsets.only(bottom: 6),
            //         child: Card(
            //           surfaceTintColor: Colors.white,
            //           color: ColorConst.websiteHomeBox,
            //           elevation: 4,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(15),
            //           ),
            //           child: Container(
            //             width: getW(context) * 0.8,
            //             height: 55,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(15),
            //                 border: Border.all(
            //                     color: ColorConst.borderColor, width: 0.6)),
            //             child: TextButton(
            //               onPressed: () {
            //                 Get.toNamed('/packages', arguments: item);
            //               },
            //               child: const Text("Book Workout",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 20,
            //                       fontWeight: FontWeight.w500)),
            //             ),
            //           ),
            //         )))
          ],
        ),
      ),
    );
  }
}
