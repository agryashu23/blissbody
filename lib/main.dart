import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/adminAddController.dart';
import 'package:blissbody_app/controllers/adminController.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/detailController.dart';
import 'package:blissbody_app/controllers/gymController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/controllers/onboardController.dart';
import 'package:blissbody_app/controllers/ownerdetailController.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/controllers/reelsController.dart';
import 'package:blissbody_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  Get.put(OnboardController());
  Get.put(ProfileController());
  Get.put(HomeController());
  Get.put(DetailController());
  Get.put(GymController());
  Get.put(OwnerHomeController());
  Get.put(OwnerDetailController());
  Get.put(ReelsController());
  Get.put(AdminController());
  Get.put(AdminAddController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blissbody',
      initialRoute: '/',
      getPages: appRoutes(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConst.websiteHomeBox),
        useMaterial3: true,
      ),
    );
  }
}
