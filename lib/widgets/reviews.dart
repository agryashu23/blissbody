import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rating_summary/rating_summary.dart';

class ReviewsWidget extends StatelessWidget {
  ReviewsWidget({super.key, required this.item});
  final Map<String, dynamic> item;

  final OwnerHomeController ownerHomeController =
      Get.find<OwnerHomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Ratings",
              style: TextStyle(
                fontSize: 16,
                color: ColorConst.titleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: RatingSummary(
                  counter: ownerHomeController.editReviews.length == 0
                      ? 1
                      : ownerHomeController.editReviews.length,
                  average: ownerHomeController.avgRating.value,
                  showAverage: true,
                  counterFiveStars: ownerHomeController.starRatings['5'] ?? 0,
                  counterFourStars: ownerHomeController.starRatings['4'] ?? 0,
                  counterThreeStars: ownerHomeController.starRatings['3'] ?? 0,
                  counterTwoStars: ownerHomeController.starRatings['2'] ?? 0,
                  counterOneStars: ownerHomeController.starRatings['1'] ?? 0,
                ),
              ),
            ),
            SizedBox(
              height: getH(context) * 0.015,
            ),
            Obx(
              () => !ownerHomeController.getExist(authController.userId.value)
                  ? const Text(
                      "Rate the gym",
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorConst.primaryGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const SizedBox(),
            ),
            SizedBox(
              height: getH(context) * 0.01,
            ),
            Obx(
              () => !ownerHomeController.getExist(authController.userId.value)
                  ? RatingBar.builder(
                      onRatingUpdate: (rating) {
                        ownerHomeController.rating.value = rating;
                      },
                      initialRating: 1,
                      glow: true,
                      glowColor: ColorConst.primary,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      allowHalfRating: false,
                      minRating: 1,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: ColorConst.websiteHomeBox,
                      ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => !ownerHomeController.getExist(authController.userId.value)
                  ? Container(
                      width: getW(context) * 0.3,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: ColorConst.borderColor, width: 0.6)),
                      child: TextButton(
                        onPressed: () {
                          ownerHomeController.editgymReviews(item["_id"]);
                        },
                        child: const Text("Rate it!",
                            style: TextStyle(
                                color: ColorConst.primaryGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    )
                  : const SizedBox(),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: getW(context) * 0.7,
            //       child: TextFormField(
            //         maxLines: 2,
            //         keyboardType: TextInputType.text,
            //         controller:ownerHomeController.reviewController,
            //         style: const TextStyle(
            //             color: ColorConst.titleColor, fontSize: 15),
            //         decoration: InputDecoration(
            //           hintText: 'Say something...',
            //           hintStyle: const TextStyle(
            //               color: ColorConst.primaryGrey,
            //               fontWeight: FontWeight.w400,
            //               fontSize: 14),
            //           contentPadding: const EdgeInsets.symmetric(
            //               horizontal: 10, vertical: 6),
            //           filled: true,
            //           fillColor: ColorConst.primaryGrey.withOpacity(0.1),
            //           enabledBorder: const OutlineInputBorder(
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(10.0),
            //             ),
            //             borderSide: BorderSide(color: Colors.white),
            //           ),
            //           focusedBorder: const OutlineInputBorder(
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(10.0),
            //             ),
            //             borderSide: BorderSide(color: Colors.white),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 4,
            //     ),
            //     Container(
            //       height: 40,
            //       width: 40,
            //       decoration: const BoxDecoration(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10),
            //         ),
            //         color: ColorConst.websiteHomeBox,
            //       ),
            //       child: IconButton(
            //         onPressed: () async {},
            //         icon: const Icon(
            //           Icons.arrow_forward_ios,
            //           color: Colors.white,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
