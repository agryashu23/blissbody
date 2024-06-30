import 'dart:ui';
import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/detailController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:date_picker_timetable/date_picker_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SlotPage extends StatefulWidget {
  const SlotPage({super.key});

  @override
  State<SlotPage> createState() => _SlotPageState();
}

class _SlotPageState extends State<SlotPage> {
  final DetailController detailController = Get.find<DetailController>();
  final AuthController authController = Get.find<AuthController>();
  final DatePickerController controller = DatePickerController();
  var item = Get.arguments as Map<String, dynamic>;

  final weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      detailController.morningSlots.assignAll(detailController.createTimeSlots(
          item['morning_time'][0], item['morning_time'][1]));
      detailController.eveningSlots.assignAll(detailController.createTimeSlots(
          item['evening_time'][0], item['evening_time'][1]));
      String dayName = weekDays[DateTime.now().weekday - 1];
      detailController.selectedDay.value = dayName;
      detailController.selectedDate.value =
          DateFormat('dd-MM-yyyy').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: authController.isDarkMode.value
            ? Colors.black
            : Colors.grey.shade100,
        centerTitle: true,
        title: Text(
          "CHOOSE A SLOT",
          style: TextStyle(
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
              letterSpacing: 1.3,
              fontSize: 17),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: getH(context) * 0.005),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DatePicker(
              controller: controller,
              locale: "en_EN",
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              width: getW(context) * 0.15,
              height: getH(context) * 0.12,
              selectionColor: ColorConst.websiteHomeBox,
              deactivatedColor: Colors.grey,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                detailController.unselectedDate.value = false;
                detailController.selectedDate.value =
                    DateFormat('dd-MM-yyyy').format(date);
                String dayName = weekDays[date.weekday - 1];
                detailController.selectedDay.value = dayName;
              },
            ),
            Divider(
              height: 6,
              color: Colors.grey.shade200,
            ),
            SizedBox(
              height: getH(context) * 0.02,
            ),
            Obx(
              () => item['days'].contains(detailController.selectedDay.value)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.05),
                      child: const Text(
                        "Morning Slot",
                        style: TextStyle(
                            color: ColorConst.titleColor,
                            letterSpacing: 1,
                            fontSize: 15),
                      ),
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => item['days'].contains(detailController.selectedDay.value)
                  ? Expanded(
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getW(context) * 0.05),
                          child: ListView.builder(
                              itemCount: detailController.morningSlots.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getH(context) * 0.007),
                                  child: GestureDetector(
                                    onTap: () {
                                      detailController.gymId.value =
                                          item['_id'];
                                      detailController.selectedTime.value =
                                          detailController.morningSlots[index];
                                      detailController.receive.value =
                                          item['user'];
                                      Razorpay razorpay = Razorpay();
                                      var options = {
                                        'key': 'rzp_test_FhXkOzMlVtTyGh',
                                        'amount': int.parse(detailController
                                                .selectedPrice.value) *
                                            100,
                                        'name': 'Blissbody',
                                        'description': item['name'],
                                        'retry': {
                                          'enabled': true,
                                          'max_count': 1
                                        },
                                        'send_sms_hash': true,
                                        'timeout': 300,
                                        'prefill': {
                                          'contact':
                                              "+91${authController.phoneNo.value}",
                                          'email': 'test@razorpay.com'
                                        },
                                        'external': {
                                          'wallets': ['paytm']
                                        }
                                      };
                                      razorpay.on(
                                          Razorpay.EVENT_PAYMENT_ERROR,
                                          detailController
                                              .handlePaymentErrorResponse);
                                      razorpay.on(
                                          Razorpay.EVENT_PAYMENT_SUCCESS,
                                          detailController
                                              .handlePaymentSuccessResponse);
                                      razorpay.on(
                                          Razorpay.EVENT_EXTERNAL_WALLET,
                                          detailController
                                              .handleExternalWalletSelected);
                                      razorpay.open(options);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color:
                                                    ColorConst.websiteHomeBox,
                                                width: 0.4)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: getH(context) * 0.07,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                  color:
                                                      ColorConst.websiteHomeBox,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8))),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.fitness_center_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: getW(context) * 0.05,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                const Text(
                                                  "Gym Workout",
                                                  style: TextStyle(
                                                      color:
                                                          ColorConst.titleColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  detailController
                                                      .morningSlots[index],
                                                  style: const TextStyle(
                                                      color: ColorConst
                                                          .primaryGrey,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: getH(context) * 0.3),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.fitness_center_sharp),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Gym closed",
                            style: TextStyle(
                                color: ColorConst.titleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(
              height: getH(context) * 0.02,
            ),
            Obx(
              () => item['days'].contains(detailController.selectedDay.value)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getW(context) * 0.05),
                      child: const Text(
                        "Evening Slot",
                        style: TextStyle(
                            color: ColorConst.titleColor,
                            letterSpacing: 1,
                            fontSize: 15),
                      ),
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => item['days'].contains(detailController.selectedDay.value)
                  ? Expanded(
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getW(context) * 0.05),
                          child: ListView.builder(
                              itemCount: detailController.eveningSlots.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getH(context) * 0.007),
                                  child: GestureDetector(
                                    onTap: () {
                                      Razorpay razorpay = Razorpay();
                                      detailController.gymId.value =
                                          item['_id'];
                                      detailController.selectedTime.value =
                                          detailController.morningSlots[index];
                                      detailController.receive.value =
                                          item['user'];
                                      var options = {
                                        'key': 'rzp_test_AEY2KkwsOqtacJ',
                                        'amount': int.parse(detailController
                                                .selectedPrice.value) *
                                            100,
                                        'name': 'Blissbody',
                                        'description': item['name'],
                                        'retry': {
                                          'enabled': true,
                                          'max_count': 1
                                        },
                                        'send_sms_hash': true,
                                        'prefill': {
                                          'contact':
                                              "+91${authController.phoneNo.value}",
                                          'email': 'test@razorpay.com'
                                        },
                                        'external': {
                                          'wallets': ['paytm']
                                        }
                                      };
                                      razorpay.on(
                                          Razorpay.EVENT_PAYMENT_ERROR,
                                          detailController
                                              .handlePaymentErrorResponse);
                                      razorpay.on(
                                          Razorpay.EVENT_PAYMENT_SUCCESS,
                                          detailController
                                              .handlePaymentSuccessResponse);
                                      razorpay.on(
                                          Razorpay.EVENT_EXTERNAL_WALLET,
                                          detailController
                                              .handleExternalWalletSelected);
                                      razorpay.open(options);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color:
                                                    ColorConst.websiteHomeBox,
                                                width: 0.4)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: getH(context) * 0.07,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                  color:
                                                      ColorConst.websiteHomeBox,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8))),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.fitness_center_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: getW(context) * 0.05,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                const Text(
                                                  "Gym Workout",
                                                  style: TextStyle(
                                                      color:
                                                          ColorConst.titleColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  detailController
                                                      .eveningSlots[index],
                                                  style: const TextStyle(
                                                      color: ColorConst
                                                          .primaryGrey,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
