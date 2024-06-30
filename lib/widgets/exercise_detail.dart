import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseDetail extends StatefulWidget {
  ExerciseDetail({super.key});

  @override
  State<ExerciseDetail> createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  final AuthController authController = Get.find<AuthController>();

  var item = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          authController.isDarkMode.value ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          item,
          style: TextStyle(
              fontSize: 18,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.05),
        child: ListView.builder(
            itemCount: workoutExercises[item]!.length,
            itemBuilder: (context, index) {
              return Card(
                color: authController.isDarkMode.value
                    ? ColorConst.dark
                    : Colors.white,
                surfaceTintColor: authController.isDarkMode.value
                    ? ColorConst.dark
                    : Colors.white,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 10,
                      top: getH(context) * 0.025,
                      bottom: getH(context) * 0.025),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fitness_center_sharp,
                        color: authController.isDarkMode.value
                            ? Colors.white
                            : ColorConst.titleColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        workoutExercises[item]![index],
                        style: TextStyle(
                            color: authController.isDarkMode.value
                                ? Colors.white
                                : ColorConst.titleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
