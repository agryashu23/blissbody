import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class UserReels extends StatefulWidget {
  const UserReels({super.key});

  @override
  State<UserReels> createState() => _UserReelsState();
}

class _UserReelsState extends State<UserReels> {
  final AuthController authController = Get.find<AuthController>();
  // final List<String> videos = [
  //   'https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-father-and-his-little-daughter-eating-marshmallows-in-nature-39765-large.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
  // ];

  late PageController pageController;
  late VideoPlayerController controller;
  Map<int, VideoPlayerController> controllers = {};
  int currentIndex = 0;
  Map<int, double> videoProgress = {};

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    for (var i = 0; i < reelsController.userReels.length; i++) {
      controllers[i] = VideoPlayerController.networkUrl(
          Uri.parse(reelsController.userReels[i]['url']))
        ..initialize().then((_) {
          setState(() {});
          if (i == 0) controllers[i]!.play();
          controllers[i]!.addListener(() {
            final progress = controllers[i]!.value.position.inSeconds /
                controllers[i]!.value.duration.inSeconds;
            setState(() {
              videoProgress[i] = progress;
            });
          });
        });
    }
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MY REELS",
          style: TextStyle(
            fontSize: 17,
            color: authController.isDarkMode.value
                ? Colors.white
                : ColorConst.titleColor,
          ),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: authController.isDarkMode.value
              ? Colors.white
              : ColorConst.titleColor,
        ),
        centerTitle: true,
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        elevation: 0,
      ),
      backgroundColor:
          authController.isDarkMode.value ? Colors.black : Colors.white,
      body: Obx(
        () => reelsController.userReels.isEmpty
            ? const Center(
                child: Text(
                  "You haven't created any reels",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: reelsController.userReels.length,
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
                                      reelsController.userReels[index]['image'],
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
                                  reelsController.userReels[index]['name'],
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
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: ColorConst.websiteHomeBox,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Loading Reels...",
                style: TextStyle(
                  color: authController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
              )
            ],
          ));
  }

  Widget _imageView(int index) {
    return GestureDetector(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              reelsController.userReels[index]['url'],
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
                                reelsController.userReels[index]['image'],
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
                            reelsController.userReels[index]['name'],
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
