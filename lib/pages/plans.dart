import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/constants/images.dart';
import 'package:blissbody_app/controllers/gymController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/pages/mainpage.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/plan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Plans extends StatefulWidget {
  const Plans({super.key});

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  final GymController gymController = Get.find<GymController>();

  @override
  void initState() {
    super.initState();
    gymController.getPlans();
  }

  @override
  Widget build(BuildContext context) {
    return MainPage(
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset(
                    onboard1Image,
                    width: double.infinity,
                    height: getH(context) * 0.16,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: getH(context) * 0.06),
                    child: Center(
                      child: const Text(
                        "WEEKLY WORKOUT PLAN",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: getH(context) * 0.11),
                      width: getW(context) * 0.2,
                      height: getH(context) * 0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ColorConst.borderColor, width: 1)),
                      child: GestureDetector(
                        onTap: () {
                          gymController.savePlans();
                        },
                        child: Text("Save",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/exercises");
                },
                child: Card(
                  elevation: 2,
                  margin:
                      EdgeInsets.symmetric(horizontal: getW(context) * 0.26),
                  color: ColorConst.dark,
                  surfaceTintColor: ColorConst.dark,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: getH(context) * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          "https://i.pinimg.com/originals/1c/03/26/1c0326e1f7aa89855ab1677bd023f0ff.png",
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "EXERCISES",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getH(context) * 0.02,
              ),
              PlanWidget("Monday", gymController.Monday),
              PlanWidget("Tuesday", gymController.Tuesday),
              PlanWidget("Wednesday", gymController.Wednesday),
              PlanWidget("Thursday", gymController.Thursday),
              PlanWidget("Friday", gymController.Friday),
              PlanWidget("Saturday", gymController.Saturday),
              PlanWidget("Sunday", gymController.Sunday),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
