import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/ownerhomeController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({super.key, required this.item});
  final Map<String, dynamic> item;

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  final OwnerHomeController ownerHomeController =
      Get.find<OwnerHomeController>();
  final Map<String, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: const MarkerId("Gym"),
        position: LatLng(ownerHomeController.latitude.value,
            ownerHomeController.longitude.value),
      );
      _markers["Gym"] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: getH(context) * 0.02,
              left: getW(context) * 0.03,
              right: getW(context) * 0.03),
          child: const Text(
            'MAJOR MACHINES',
            style: TextStyle(
                fontSize: 15,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                color: ColorConst.primaryGrey),
          ),
        ),
        Container(
          height: widget.item["machines"].length * (getW(context) * 0.063),
          margin: EdgeInsets.only(left: getW(context) * 0.1),
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 4),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 0,
                childAspectRatio: 4),
            itemCount: widget.item["machines"].length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                      backgroundColor: ColorConst.primaryGrey, radius: 4),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    widget.item["machines"][index],
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: ColorConst.titleColor),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: getH(context) * 0.02,
              left: getW(context) * 0.03,
              right: getW(context) * 0.03),
          child: const Text(
            'ABOUT',
            style: TextStyle(
                fontSize: 15,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                color: ColorConst.primaryGrey),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: 4,
              left: getW(context) * 0.035,
              right: getW(context) * 0.035),
          child: Text(
            widget.item['about'],
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ColorConst.titleColor),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: getH(context) * 0.02,
              horizontal: getW(context) * 0.035),
          decoration: BoxDecoration(
              border: Border.all(color: ColorConst.borderColor),
              borderRadius: BorderRadius.circular(8)),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: getW(context) * 0.5,
                  padding: EdgeInsets.only(
                    top: getH(context) * 0.008,
                    bottom: getH(context) * 0.008,
                    left: getW(context) * 0.02,
                    right: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'LOCATION',
                        style: TextStyle(
                            fontSize: 13,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w600,
                            color: ColorConst.primaryGrey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item['address'],
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: ColorConst.titleColor),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: Obx(
                      () => ownerHomeController.latitude.value == 0.0
                          ? Center(child: CircularProgressIndicator())
                          : GoogleMap(
                              onMapCreated: _onMapCreated,
                              zoomControlsEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    ownerHomeController.latitude.value,
                                    ownerHomeController.longitude.value),
                                zoom: 15.0,
                              ),
                              markers: _markers.values.toSet(),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
