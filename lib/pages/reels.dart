import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/reelsController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class Reels extends StatefulWidget {
  const Reels({super.key});

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  final ReelsController reelsController = Get.find<ReelsController>();

  late PageController pageController;
  late VideoPlayerController controller;
  Map<int, VideoPlayerController> controllers = {};
  int currentIndex = 0;
  Map<int, double> videoProgress = {};

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    reelsController.getReels();
    reelsController.reels.asMap().forEach((index, reel) {
      if (reel['type'] == 'video') {
        controllers[index] =
            VideoPlayerController.networkUrl(Uri.parse(reel['url']))
              ..initialize().then((_) {
                setState(() {});
                if (index == 0) controllers[index]?.play();
                controllers[index]?.addListener(() {
                  final progress =
                      controllers[index]!.value.position.inSeconds /
                          controllers[index]!.value.duration.inSeconds;
                  setState(() {
                    videoProgress[index] = progress;
                  });
                });
              });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    controllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
            title: Text(
              "REELS",
              style: TextStyle(
                fontSize: 17,
                color: authController.isDarkMode.value
                    ? Colors.white
                    : ColorConst.titleColor,
              ),
            ),
            centerTitle: true,
            backgroundColor:
                authController.isDarkMode.value ? Colors.black : Colors.white,
            elevation: 0,
            actions: [
              GestureDetector(
                onTap: () {
                  controllers[currentIndex]?.pause();
                  Get.toNamed('/choose/video');
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.add_a_photo, size: 20)),
              )
            ]),
        body: Obx(
          () => reelsController.reels.length == 0
              ? Center(
                  child: labelName(context, "No Reels found.."),
                )
              : PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: reelsController.reels.length,
                  controller: pageController,
                  onPageChanged: (index) {
                    currentIndex = index;
                    controllers.forEach((key, value) {
                      if (key == index) {
                        value.play();
                      } else {
                        value.pause();
                      }
                    });
                  },
                  itemBuilder: (context, index) {
                    final reel = reelsController.reels[index];
                    if (reel['type'] == 'video') {
                      return _videoPlayer(index);
                    } else {
                      return _imageView(index);
                    }
                  },
                ),
        ),
      ),
    );
  }

  Widget _videoPlayer(int index) {
    return controllers[index]!.value.isInitialized
        ? GestureDetector(
            onTap: () {
              if (controllers[index]!.value.isPlaying) {
                controllers[index]!.pause();
              } else {
                controllers[index]!.play();
              }
            },
            child: Stack(
              children: [
                VideoPlayer(controllers[index]!),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 50, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      reelsController.reels[index]['image'],
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    )),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                color: Colors.black12,
                                child: Text(
                                  reelsController.reels[index]['name'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                        LinearProgressIndicator(
                          value: videoProgress[index] ?? 0,
                          backgroundColor: Colors.white,
                          color: ColorConst.websiteHomeBox,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              ColorConst.websiteHomeBox),
                        ),
                      ],
                    ))
              ],
            ),
          )
        : Container(
            color:
                authController.isDarkMode.value ? Colors.black : Colors.white,
            child: const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: ColorConst.websiteHomeBox,
                ),
                SizedBox(
                  height: 4,
                ),
                Text("Loading Reels...")
              ],
            )),
          );
  }

  Widget _imageView(int index) {
    return GestureDetector(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              reelsController.reels[index]['url'],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: ColorConst.websiteHomeBox,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text("Loading Reels...")
                  ],
                ));
              },
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                reelsController.reels[index]['image'],
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              )),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          color: Colors.black12,
                          child: Text(
                            reelsController.reels[index]['name'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
