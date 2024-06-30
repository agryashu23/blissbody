import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: context.width,
          height: context.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.grey.shade400,
            Colors.grey.shade200,
            Colors.white
          ])),
        ),
        child
      ],
    );
  }
}
