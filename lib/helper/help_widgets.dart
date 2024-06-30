import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

double getW(context) {
  return MediaQuery.of(context).size.width;
}

double getH(context) {
  return MediaQuery.of(context).size.height;
}

double getF(context, size) {
  return MediaQuery.of(context).textScaler.scale(size);
}

Widget commonCacheImageWidget(String url, double? height,
    {double? width, BoxFit? fit}) {
  if (url.startsWith('https')) {
    return Image.network(url, height: height, width: width, fit: fit);
  } else {
    return Image.asset(url, height: height, width: width, fit: fit);
  }
}

Widget heightWidget(
  String title,
  String title2,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title2.isEmpty ? "--" : title2,
        style: const TextStyle(
            color: ColorConst.titleColor,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      Text(
        title,
        style: const TextStyle(
            color: ColorConst.primaryGrey,
            fontSize: 12,
            fontWeight: FontWeight.w400),
      )
    ],
  );
}

Widget verticalDivider(context) {
  return SizedBox(
    height: getH(context) * 0.05, // Match to your design
    child: VerticalDivider(
      width: 20, // The width space it takes to draw divider
      thickness: 1, // The thickness of the divider line
      color: Colors.grey[300], // The color of the divider
    ),
  );
}

final AuthController authController = Get.find<AuthController>();
Widget profileTiles(context, IconData icon, String title, String subtitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        icon,
        color: authController.isDarkMode.value ? Colors.white : Colors.black,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: authController.isDarkMode.value
                    ? Colors.white
                    : Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
              width: getW(context) * 0.7,
              child: Text(
                subtitle,
                style: const TextStyle(
                  letterSpacing: 0.2,
                  color: Color.fromARGB(255, 123, 120, 120),
                  fontSize: 12,
                ),
              )),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: getH(context) * 0.03),
        child: const Icon(
          Icons.arrow_forward_ios_outlined,
          weight: 2,
          size: 18,
        ),
      )
    ],
  );
}

Widget ownerTiles(context, IconData icon, String title, String subtitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon,
          color: authController.isDarkMode.value
              ? Colors.white
              : ColorConst.titleColor),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
              width: getW(context) * 0.7,
              child: Text(
                subtitle,
                style: const TextStyle(
                  letterSpacing: 0.2,
                  color: Color.fromARGB(255, 123, 120, 120),
                  fontSize: 12,
                ),
              )),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: getH(context) * 0.03),
        child: const Icon(
          Icons.arrow_forward_ios_outlined,
          weight: 2,
          size: 18,
        ),
      )
    ],
  );
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> launchFunction(String url) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}
