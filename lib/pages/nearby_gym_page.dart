import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/nearby_gym.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NearbyGymsPage extends StatefulWidget {
  const NearbyGymsPage({super.key});

  @override
  State<NearbyGymsPage> createState() => _NearbyGymsPageState();
}

class _NearbyGymsPageState extends State<NearbyGymsPage> {
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Explore gyms",
          style: TextStyle(
              color: ColorConst.titleColor,
              letterSpacing: 1.5,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => homeController.isLoading.value
            ? const Center(child:CircularProgressIndicator())
            : homeController.gyms.isEmpty
                ? Container(
                    height: getH(context) * 0.1,
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fitness_center_outlined,
                          color: ColorConst.primaryGrey,
                          size: 18,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "No gyms found",
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorConst.primaryGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                  height:getH(context)*0.98,
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 5),
                        shrinkWrap: true,
                        itemCount: homeController.gyms.length,
                        itemBuilder: (BuildContext context, int i) {
                          return NearbyGym(item: homeController.gyms[i]);
                        }),
                  ),
      ),
    );
  }
}
