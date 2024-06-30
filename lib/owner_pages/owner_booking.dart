import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/detailController.dart';
import 'package:blissbody_app/controllers/ownerdetailController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerBookings extends StatefulWidget {
  const OwnerBookings({super.key});

  @override
  State<OwnerBookings> createState() => _OwnerBookingsState();
}

class _OwnerBookingsState extends State<OwnerBookings> {
  final OwnerDetailController detailController =
      Get.find<OwnerDetailController>();

  @override
  void initState() {
    super.initState();
    detailController.getOwnerBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor:
              authController.isDarkMode.value ? Colors.black : Colors.white,
          appBar: AppBar(
            title: Text(
              "BOOKINGS",
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
            () => detailController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : detailController.booking.isEmpty
                    ? Center(
                        child: Text(
                        "You have not made any bookings yet.",
                        style: TextStyle(
                          color: authController.isDarkMode.value
                              ? Colors.white
                              : ColorConst.titleColor,
                        ),
                      ))
                    : SizedBox(
                        height: getH(context),
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 8),
                            itemCount: detailController.booking.length,
                            itemBuilder: (context, index) {
                              return BookingCard(
                                  item: detailController.booking[index]);
                            })),
          )),
    );
  }
}
