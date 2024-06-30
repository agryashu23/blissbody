import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget2 extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget2({super.key, required this.videoUrl});

  @override
  _VideoPlayerWidget2State createState() => _VideoPlayerWidget2State();
}

class _VideoPlayerWidget2State extends State<VideoPlayerWidget2> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
              setState(() {});
            },
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  VideoPlayer(_controller),
                  _controller.value.isPlaying
                      ? const SizedBox()
                      : Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 24,
                            ),
                          ),
                        )
                ],
              ),
            ),
          )
        : const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
