import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/ownerdetailController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rating_summary/rating_summary.dart';

class OwnerProfile extends StatefulWidget {
  const OwnerProfile({super.key});

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile>
    with SingleTickerProviderStateMixin {
  final CarouselController _carouselController = CarouselController();

  final OwnerHomeController ownerHomeController =
      Get.find<OwnerHomeController>();
  final OwnerDetailController ownerDetailController =
      Get.find<OwnerDetailController>();

  int _currentIndex = 0;

  final Map<String, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: const MarkerId("Gym"),
        position: LatLng(ownerDetailController.latitude.value,
            ownerDetailController.longitude.value),
      );
      _markers["Gym"] = marker;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ownerHomeController.locationController.text.isNotEmpty) {
        List<Location> locations = await locationFromAddress(
            ownerHomeController.locationController.text);
        ownerDetailController.latitude.value = locations[0].latitude;
        ownerDetailController.longitude.value = locations[0].longitude;
      }
    });

    super.initState();
  }

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
                      ownerHomeController.caraouselWidgets.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              child: CarouselSlider(
                                items: ownerHomeController.caraouselWidgets,
                                options: CarouselOptions(
                                    autoPlay: false,
                                    enlargeCenterPage: true,
                                    aspectRatio: 1.4,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    }),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(top: getH(context) * 0.28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: ownerHomeController.caraouselWidgets
                              .asMap()
                              .entries
                              .map((entry) {
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
                            top: getH(context) * 0.06, left: 10, right: 10),
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
                            ownerHomeController
                                    .contactController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      makePhoneCall(ownerHomeController
                                          .contactController.text);
                                    },
                                    child: const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: getW(context) * 0.03),
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
                    color: authController.isDarkMode.value
                        ? Colors.grey.shade200
                        : Colors.white,
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
                              ownerHomeController.nameController.text,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConst.titleColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getW(context) * 0.025,
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
                                  width: getW(context) * 0.8,
                                  child: Text(
                                    ownerHomeController.locationController.text,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: ColorConst.primaryGrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: getH(context) * 0.01),
                            padding: EdgeInsets.symmetric(
                              horizontal: getW(context) * 0.02,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.timer_rounded,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${ownerHomeController.openingTime.value}-${ownerHomeController.closingTime.value}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ownerHomeController.selectedGender.value ==
                                                0 ||
                                            ownerHomeController
                                                    .selectedGender.value ==
                                                2
                                        ? const Icon(
                                            Icons.male,
                                            size: 20,
                                            color: Colors.blue,
                                          )
                                        : const SizedBox(),
                                    ownerHomeController.selectedGender.value ==
                                                0 ||
                                            ownerHomeController
                                                    .selectedGender.value ==
                                                2
                                        ? const Text(
                                            'Male',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: ColorConst.primaryGrey),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    ownerHomeController.selectedGender.value ==
                                                1 ||
                                            ownerHomeController
                                                    .selectedGender.value ==
                                                2
                                        ? const Icon(
                                            Icons.female,
                                            size: 20,
                                            color: Colors.pink,
                                          )
                                        : const SizedBox(),
                                    ownerHomeController.selectedGender.value ==
                                                1 ||
                                            ownerHomeController
                                                    .selectedGender.value ==
                                                2
                                        ? const Text(
                                            'Female',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: ColorConst.primaryGrey),
                                          )
                                        : const SizedBox(),
                                  ],
                                )
                              ],
                            ),
                          ),
                          ownerHomeController.linkController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () async {
                                    await launchFunction(ownerHomeController
                                        .linkController.text);
                                  },
                                  child: Container(
                                    width: getW(context) * 0.8,
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 10),
                                    child: Text(
                                      ownerHomeController.linkController.text,
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
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getW(context) * 0.03, vertical: 7),
                            height: getH(context) * 0.065,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  ownerHomeController.editAmenities.length,
                              itemBuilder: (context, index) {
                                var title =
                                    ownerHomeController.editAmenities[index];

                                var icon =
                                    ownerDetailController.getIconByName(title);
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getW(context) * 0.05),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                  Container(
                    margin: EdgeInsets.only(
                        top: getH(context) * 0.02,
                        left: getW(context) * 0.03,
                        right: getW(context) * 0.03),
                    child: const Text(
                      'MAJOR MACHINES',
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          color: ColorConst.primaryGrey),
                    ),
                  ),
                  Container(
                    height: ownerHomeController.editMachines.length *
                        (getW(context) * 0.063),
                    margin: EdgeInsets.only(left: getW(context) * 0.1),
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 0,
                              childAspectRatio: 4),
                      itemCount: ownerHomeController.editMachines.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(
                                backgroundColor: ColorConst.primaryGrey,
                                radius: 4),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              ownerHomeController.editMachines[index],
                              textAlign: TextAlign.start,
                              style:
                                  const TextStyle(color: ColorConst.titleColor),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: getH(context) * 0.02,
                        left: getW(context) * 0.03,
                        right: getW(context) * 0.03),
                    child: const Text(
                      'ABOUT',
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          color: ColorConst.primaryGrey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 4,
                        left: getW(context) * 0.035,
                        right: getW(context) * 0.035),
                    child: Text(
                      ownerHomeController.editabout.value,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: ColorConst.titleColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: getH(context) * 0.02,
                        horizontal: getW(context) * 0.035),
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorConst.borderColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: getW(context) * 0.5,
                            padding: EdgeInsets.only(
                              top: getH(context) * 0.008,
                              bottom: getH(context) * 0.008,
                              left: getW(context) * 0.02,
                              right: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'LOCATION',
                                  style: TextStyle(
                                      fontSize: 13,
                                      letterSpacing: 2.5,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConst.primaryGrey),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  ownerHomeController.locationController.text,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConst.titleColor),
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => ownerDetailController.latitude.value == 0.0
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Expanded(
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: GoogleMap(
                                        onMapCreated: _onMapCreated,
                                        zoomControlsEnabled: false,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              ownerDetailController
                                                  .latitude.value,
                                              ownerDetailController
                                                  .longitude.value),
                                          zoom: 15.0,
                                        ),
                                        markers: _markers.values.toSet(),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, top: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: authController.isDarkMode.value
                          ? ColorConst.dark
                          : Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Ratings",
                            style: TextStyle(
                              fontSize: 16,
                              color: authController.isDarkMode.value
                                  ? Colors.white
                                  : ColorConst.titleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(
                            () => RatingSummary(
                              counter:
                                  ownerHomeController.editReviews.length == 0
                                      ? 1
                                      : ownerHomeController.editReviews.length,
                              average: ownerHomeController.avgRating.value,
                              averageStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: authController.isDarkMode.value
                                    ? Colors.white
                                    : ColorConst.titleColor,
                              ),
                              labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: authController.isDarkMode.value
                                    ? Colors.white
                                    : ColorConst.titleColor,
                              ),
                              showAverage: true,
                              counterFiveStars:
                                  ownerHomeController.starRatings['5'] ?? 0,
                              counterFourStars:
                                  ownerHomeController.starRatings['4'] ?? 0,
                              counterThreeStars:
                                  ownerHomeController.starRatings['3'] ?? 0,
                              counterTwoStars:
                                  ownerHomeController.starRatings['2'] ?? 0,
                              counterOneStars:
                                  ownerHomeController.starRatings['1'] ?? 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getH(context) * 0.015,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
