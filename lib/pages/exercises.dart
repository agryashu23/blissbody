import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Exercises extends StatelessWidget {
  Exercises({super.key});

  final AuthController authController = Get.find<AuthController>();

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
          "EXERCISES",
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
        padding:
            EdgeInsets.symmetric(horizontal: getW(context) * 0.03, vertical: 8),
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust number of columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8, // Adjust the aspect ratio
          ),
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed('/exercise/detail',
                    arguments: workouts[index]['name']);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  footer: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    color: Colors.black54,
                    child: Text(workouts[index]['name'],
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  child: Image.network(workouts[index]['image'],
                      fit: BoxFit.cover),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
