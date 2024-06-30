import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.item, this.owner});
  final Map<String, dynamic> item;
  final bool? owner;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey.shade100,
                  Colors.grey.shade200,
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
                    owner == true
                        ? item['receive']['name']
                        : item['gym']['name'],
                    style: const TextStyle(
                        fontSize: 16,
                        color: ColorConst.titleColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "${item['date']}",
                            style: const TextStyle(
                                fontSize: 14,
                                color: ColorConst.titleColor,
                                fontWeight: FontWeight.bold),
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
