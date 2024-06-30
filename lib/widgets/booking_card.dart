import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingCard extends StatelessWidget {
  BookingCard({
    super.key,
    required this.item,
  });
  final Map<String, dynamic> item;

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), side: BorderSide.none),
        elevation: 3,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.fitness_center,
                    color: ColorConst.primaryGrey,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "#${item['payment_id']}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorConst.primaryGrey,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "₹${item['price']}",
                    style: const TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.2,
                        color: ColorConst.websiteHomeBox,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    item['gym']['name'],
                    style: TextStyle(
                        fontSize: 16,
                        color: authController.isDarkMode.value
                            ? Colors.white
                            : ColorConst.titleColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                width: getW(context) * 0.9,
                child: Text(item['gym']['address'],
                    style: const TextStyle(
                        fontSize: 12,
                        color: ColorConst.primaryGrey,
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: getW(context) * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: authController.isDarkMode.value
                                ? ColorConst.primaryGrey
                                : ColorConst.titleColor,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "${item['date']}, ${item['day']}",
                            style: TextStyle(
                                fontSize: 14,
                                color: authController.isDarkMode.value
                                    ? ColorConst.primaryGrey
                                    : ColorConst.titleColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getW(context) * 0.01,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.lock_clock,
                            size: 16,
                            color: authController.isDarkMode.value
                                ? ColorConst.primaryGrey
                                : ColorConst.titleColor,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            item['time'],
                            style: TextStyle(
                                fontSize: 14,
                                color: authController.isDarkMode.value
                                    ? ColorConst.primaryGrey
                                    : ColorConst.titleColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getW(context) * 0.01,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt,
                            size: 16,
                            color: authController.isDarkMode.value
                                ? ColorConst.primaryGrey
                                : ColorConst.titleColor,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            item['package'] + " Package",
                            style: TextStyle(
                                fontSize: 14,
                                color: authController.isDarkMode.value
                                    ? ColorConst.primaryGrey
                                    : ColorConst.titleColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getW(context) * 0.01,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/save.png',
                    width: 50,
                    height: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
