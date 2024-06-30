import 'dart:async';
import 'dart:io';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/homeController.dart';
import 'package:blissbody_app/controllers/reelsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:video_trimmer/video_trimmer.dart';

class CreateReels extends StatefulWidget {
  const CreateReels({super.key});

  @override
  State<CreateReels> createState() => _CreateReelsState();
}

class _CreateReelsState extends State<CreateReels> {
  final ReelsController reelsController = Get.put(ReelsController());
  final AuthController authController = Get.find<AuthController>();
  final HomeController homeController = Get.find<HomeController>();
  var videoFile = Get.arguments as File?;
  final Trimmer trimmer = Trimmer();

  @override
  void initState() {
    super.initState();
    if (videoFile != null) {
      trimmer.loadVideo(videoFile: videoFile!).catchError((e) {
        print("Error loading video: $e");
      });
    } else {
      print("Video file is null");
    }
  }

  Future<String?> saveVideo() async {
    reelsController.progressVisibility.value = true;
    reelsController.isLoadingValue.value = true;
    String? outputPath;
    Completer<void> completer =
        Completer<void>(); // Use a completer to handle async onSave

    await trimmer.saveTrimmedVideo(
        startValue: reelsController.startValue.value,
        endValue: reelsController.endValue.value,
        onSave: (output) {
          outputPath = output;
          if (outputPath != null) {
            reelsController.outputUrl.value = outputPath.toString();
            completer.complete();
          } else {
            reelsController.progressVisibility.value = false;
            reelsController.isLoadingValue.value = false;
            Get.snackbar('Error', 'Failed to save video',
                icon: const Icon(Icons.error));
            completer.completeError('Failed to save video');
          }
        });

    await completer.future;
    if (outputPath != null) {
      await uploadReelToS3(outputPath.toString());

      await reelsController.saveReel();
    }
    return outputPath;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   reelsController.trimmer.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getH(context) * 0.02,
                ),
                const Center(
                  child: Text(
                    "You can add a 30 seconds video",
                    style: TextStyle(color: ColorConst.primaryGrey),
                  ),
                ),
                SizedBox(
                  height: getH(context) * 0.01,
                ),

                Expanded(
                    child: GestureDetector(
                  onTap: () async {
                    bool playbackState = await trimmer.videPlaybackControl(
                      startValue: reelsController.startValue.value,
                      endValue: reelsController.endValue.value,
                    );

                    reelsController.isPlaying.value = playbackState;
                  },
                  child: VideoViewer(
                    trimmer: trimmer,
                  ),
                )),
                Center(
                  child: TrimEditor(
                    trimmer: trimmer,
                    viewerHeight: 70,
                    viewerWidth: getW(context) * 0.95,
                    maxVideoLength: const Duration(seconds: 30),
                    onChangeStart: (value) {
                      reelsController.startValue.value = value;
                    },
                    onChangeEnd: (value) {
                      reelsController.endValue.value = value;
                    },
                    onChangePlaybackState: (value) {
                      reelsController.isPlaying.value = false;
                    },
                  ),
                ),
                SizedBox(
                  height: getH(context) * 0.04,
                ),
                Obx(
                  () => submitBtn(
                    context,
                    reelsController.isLoadingValue.value
                        ? "Please wait.."
                        : "Save video",
                    () async {
                      await saveVideo();
                      homeController.scaffoldKey = GlobalKey<ScaffoldState>();
                      Get.offAllNamed('/start');
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
