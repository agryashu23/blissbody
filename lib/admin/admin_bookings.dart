import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/adminController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminBookings extends StatefulWidget {
  const AdminBookings({super.key});

  @override
  State<AdminBookings> createState() => _AdminBookingsState();
}

class _AdminBookingsState extends State<AdminBookings> {
  final AdminController adminController = Get.find<AdminController>();

  @override
  void initState() {
    super.initState();
    adminController.getBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bookings",
          style: TextStyle(
            fontSize: 17,
            letterSpacing: 1.5,
            color: ColorConst.titleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => adminController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : adminController.bookings.isEmpty
                ? const Center(
                    child: Text("You have not made any bookings yet."))
                : SizedBox(
                    height: getH(context),
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        itemCount: adminController.bookings.length,
                        itemBuilder: (context, index) {
                          return BookingCard(
                              item: adminController.bookings[index]);
                        })),
      ),
    );
  }
}
