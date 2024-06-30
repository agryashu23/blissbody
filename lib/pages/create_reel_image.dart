import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/reelsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';

class CreateReelImage extends StatefulWidget {
  const CreateReelImage({super.key});

  @override
  State<CreateReelImage> createState() => _CreateReelImageState();
}

class _CreateReelImageState extends State<CreateReelImage> {
  final AuthController authController = Get.find<AuthController>();

  final ReelsController reelsController = Get.put(ReelsController());
  var imageFile = Get.arguments as RxList<Uint8List>;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor:
              authController.isDarkMode.value ? Colors.black : Colors.white,
          title: Text(
            "Create Reel",
            style: TextStyle(
              fontSize: 17,
              letterSpacing: 1.5,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getH(context) * 0.02,
                ),
                Image.memory(
                  imageFile[0],
                  width: getW(context),
                  height: getH(context) * 0.6,
                ),

                SizedBox(
                  height: getH(context) * 0.06,
                ),
                Obx(
                  () => submitBtn(
                    context,
                    reelsController.isLoading.value
                        ? "Please wait.."
                        : "Save reel",
                    () async {
                      await uploadReelImageToS3(imageFile);
                      await reelsController.saveReel();
                    },
                  ),
                ),
                SizedBox(
                  height: getH(context) * 0.03,
                ),
                // Obx(() => reelsController.isPicked.value
                //     ? Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           SizedBox(
                //             height: getH(context) * 0.4,
                //             child: GestureDetector(
                //               onTap: () async {
                //                 bool playbackState =
                //                     await reelsController.trimmer.videPlaybackControl(
                //                   startValue: reelsController.startValue.value,
                //                   endValue: reelsController.endValue.value,
                //                 );
                //                 reelsController.isPlaying.value = playbackState;
                //               },
                //               child: Stack(
                //                 children: [
                //                   VideoViewer(
                //                     trimmer: reelsController.trimmer,
                //                     borderColor: Colors.black,
                //                     borderWidth: 1,
                //                   ),
                //                   Center(
                //                     child: reelsController.isPlaying.value
                //                         ? const SizedBox()
                //                         : const CircleAvatar(
                //                             backgroundColor: Colors.black26,
                //                             radius: 30,
                //                             child: Icon(
                //                               Icons.play_arrow,
                //                               size: 50.0,
                //                               color: Colors.white,
                //                             ),
                //                           ),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ),
                //           TrimEditor(
                //             trimmer: reelsController.trimmer,
                //             viewerHeight: 70.0,
                //             viewerWidth: MediaQuery.of(context).size.width,
                //             maxVideoLength: Duration(
                //                 seconds: reelsController.trimmer
                //                     .videoPlayerController!.value.duration.inSeconds),
                //             circleSize: 8.0,
                //             onChangeStart: (value) {
                //               reelsController.startValue.value = value;
                //             },
                //             onChangeEnd: (value) {
                //               reelsController.endValue.value = value;
                //             },
                //             durationTextStyle:
                //                 const TextStyle(color: ColorConst.primaryGrey),
                //             onChangePlaybackState: (value) {
                //               reelsController.isPlaying.value = false;
                //             },
                //           ),
                //           SizedBox(height: getH(context) * 0.05),
                //         ],
                //       )
                //     : Container()),
              ],
            ),
            Obx(
              () => reelsController.isLoadingValue.value
                  ? Container(
                      height: getH(context),
                      width: getW(context),
                      decoration: const BoxDecoration(color: Colors.black26),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: ColorConst.websiteHomeBox,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Creating your reel...",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ))
                  : const SizedBox(height: 0),
            )
          ],
        ),
      ),
    );
  }
}
