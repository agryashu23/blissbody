import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/adminController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/nearby_gym.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminGyms extends StatefulWidget {
  const AdminGyms({super.key});

  @override
  State<AdminGyms> createState() => _AdminGymsState();
}

class _AdminGymsState extends State<AdminGyms> {
  final AdminController adminController = Get.find<AdminController>();
  @override
  void initState() {
    super.initState();
    adminController.getAdminGyms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GYMS",
          style: TextStyle(
            fontSize: 17,
            color: ColorConst.titleColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () => adminController.isLoading.value
            ? const CircularProgressIndicator()
            : adminController.gyms.isEmpty
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
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 5),
                        shrinkWrap: true,
                        itemCount: adminController.gyms.length,
                        itemBuilder: (BuildContext context, int i) {
                          return NearbyGym(item: adminController.gyms[i]);
                        }),
                  ),
      ),
    );
  }
}
