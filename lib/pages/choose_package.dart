import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/detailController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookPackages extends StatefulWidget {
  const BookPackages({super.key});

  @override
  State<BookPackages> createState() => _BookPackagesState();
}

class _BookPackagesState extends State<BookPackages> {
  final DetailController detailController = Get.find<DetailController>();

  var item = Get.arguments as Map<String, dynamic>;

  String? getPriceByName(String packageName) {
    for (var package in item['packages']) {
      if (package["name"] == packageName) {
        return package["price"];
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    detailController.selectedPrice.value = getPriceByName('1 Month').toString();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: authController.isDarkMode.value
            ? Colors.black
            : Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: authController.isDarkMode.value
              ? Colors.black
              : Colors.grey.shade100,
          centerTitle: true,
          title: Text(
            "PACKAGES",
            style: TextStyle(
                fontSize: 17,
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
                letterSpacing: 1.5),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  item['hour_package'] != null &&
                          item['hour_package'].isNotEmpty &&
                          item['hour_package'][1] != ""
                      ? Card(
                          margin: EdgeInsets.only(
                              top: getH(context) * 0.015,
                              left: getW(context) * 0.03,
                              right: getW(context) * 0.03),
                          color: authController.isDarkMode.value
                              ? Colors.grey.shade100
                              : Colors.white,
                          surfaceTintColor: authController.isDarkMode.value
                              ? Colors.grey.shade100
                              : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: SizedBox(
                            height: getH(context) * 0.11,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => RadioListTile<String>(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: getW(context) * 0.015,
                                        vertical: getH(context) * 0.002),
                                    title: Text(
                                      '${item['hour_package'][0]} PASS',
                                      style: const TextStyle(
                                          color: ColorConst.titleColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    secondary: Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        "₹${item['hour_package'][1]}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                    // tileColor: detailController.selectedOption.value ==
                                    //         '1 Hour'
                                    //     ? ColorConst.websiteHomeBox.withOpacity(0.1)
                                    //     : Colors.white,
                                    activeColor: ColorConst.websiteHomeBox,
                                    subtitle: const Text(
                                      'Check gym and its workout with your compatibitly.',
                                      style: TextStyle(
                                          color: ColorConst.primaryGrey,
                                          fontSize: 14),
                                    ),
                                    value: item['hour_package'][0].toString(),
                                    groupValue:
                                        detailController.selectedOption.value,
                                    onChanged: (value) {
                                      detailController.selectedOption.value =
                                          value!;
                                      detailController.selectedPrice.value =
                                          item['hour_package'][1].toString();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Card(
                    margin: EdgeInsets.only(
                        top: getH(context) * 0.015,
                        left: getW(context) * 0.03,
                        right: getW(context) * 0.03),
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: SizedBox(
                        height:
                            (item['packages'].length) * getH(context) * 0.11,
                        child: ListView.builder(
                            itemCount: item['packages'].length,
                            itemBuilder: (context, index) {
                              var package = item['packages'][index];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(
                                    () => RadioListTile<String>(
                                      tileColor: authController.isDarkMode.value
                                          ? Colors.grey.shade100
                                          : Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: getW(context) * 0.015,
                                          vertical: getH(context) * 0.002),
                                      title: Text(
                                        '${package['name']} PASS',
                                        style: const TextStyle(
                                            color: ColorConst.titleColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      secondary: Container(
                                        margin: const EdgeInsets.only(right: 4),
                                        child: Text(
                                          "₹${package['price']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ),
                                      // tileColor:
                                      //     detailController.selectedOption.value ==
                                      //             '${index + 1} Month'
                                      //         ? ColorConst.websiteHomeBox
                                      //             .withOpacity(0.1)
                                      //         : Colors.white,
                                      activeColor: ColorConst.websiteHomeBox,
                                      subtitle: const Text(
                                        'Have any workout at each fitness centre in.',
                                        style: TextStyle(
                                            color: ColorConst.primaryGrey,
                                            fontSize: 14),
                                      ),
                                      value: package['name'].toString(),
                                      groupValue:
                                          detailController.selectedOption.value,
                                      onChanged: (value) {
                                        detailController.selectedOption.value =
                                            value!;
                                        detailController.selectedPrice.value =
                                            package['price'];
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey.shade100,
                                    height: 3,
                                  ),
                                ],
                              );
                            })),
                  ),
                  Card(
                    margin: EdgeInsets.only(
                        top: getH(context) * 0.02,
                        left: getW(context) * 0.03,
                        right: getW(context) * 0.03),
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getW(context) * 0.04,
                            vertical: getH(context) * 0.012),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "ORDER DETAILS",
                              style: TextStyle(
                                  color: ColorConst.titleColor,
                                  letterSpacing: 1.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: getH(context) * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Membership Price",
                                  style: TextStyle(
                                      color: ColorConst.primaryGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Obx(
                                  () => Text(
                                    "₹${detailController.selectedPrice.value}",
                                    style: const TextStyle(
                                        color: ColorConst.titleColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "GST & Applicable charges",
                                  style: TextStyle(
                                      color: ColorConst.primaryGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "₹0.0",
                                  style: TextStyle(
                                      color: ColorConst.titleColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discount",
                                  style: TextStyle(
                                      color: ColorConst.primaryGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "₹0.0",
                                  style: TextStyle(
                                      color: ColorConst.titleColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Divider(
                              color: ColorConst.borderColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Payable Amount",
                                  style: TextStyle(
                                      color: ColorConst.titleColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Obx(
                                  () => Text(
                                    "₹${detailController.selectedPrice.value}",
                                    style: const TextStyle(
                                        color: ColorConst.titleColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: getH(context) * 0.1,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.zero,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getW(context) * 0.1,
                            vertical: getW(context) * 0.05),
                        width: getW(context) * 0.55,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Text(
                          "₹${detailController.selectedPrice.value}",
                          style: const TextStyle(
                              color: ColorConst.titleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/slots', arguments: item);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getW(context) * 0.05,
                            vertical: getW(context) * 0.05),
                        width: getW(context) * 0.45,
                        decoration: const BoxDecoration(
                            color: ColorConst.websiteHomeBox),
                        child: const Text(
                          textAlign: TextAlign.center,
                          "PROCEED",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
