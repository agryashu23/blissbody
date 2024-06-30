import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 17,
            letterSpacing: 1.5,
            color: ColorConst.titleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 12, left: 8, right: 8),
        child: Markdown(
          data: markdown,
        ),
      ),
    );
  }
}
