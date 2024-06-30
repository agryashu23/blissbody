import 'package:blissbody_app/controllers/authController.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/helper/help_widgets.dart';

import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileController profileController = Get.find<ProfileController>();

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor:
              authController.isDarkMode.value ? Colors.black : Colors.white,
          centerTitle: true,
          title: Text(
            "EDIT PROFILE",
            style: TextStyle(
              fontSize: 17,
              letterSpacing: 1,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
            ),
          ),
        ),
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        body: Container(
          margin: EdgeInsets.only(
              left: getW(context) * 0.04, right: getW(context) * 0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getH(context) * 0.016,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      profileController.pickImage(ImageSource.gallery);
                    },
                    child: Stack(
                      children: [
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorConst.borderColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(80))),
                            child: profileController.pickedImage.isEmpty &&
                                    profileController.imageUrl.isEmpty
                                ? CircleAvatar(
                                    backgroundColor: ColorConst.titleColor,
                                    radius: 50,
                                    child: Center(
                                      child: Icon(Icons.person,
                                          color: Colors.white,
                                          size: getW(context) * 0.2),
                                    ))
                                : profileController.pickedImage.isNotEmpty
                                    ? CircleAvatar(
                                        backgroundImage: MemoryImage(
                                            profileController.pickedImage[0]),
                                        radius: 50,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            profileController.imageUrl.value),
                                        radius: 50,
                                      ),
                          ),
                        ),
                        const Positioned(
                            bottom: 2, right: 8, child: Icon(Icons.camera_alt))
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.025),
                    child: labelName(context, "Name")),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: getH(context) * 0.005),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: profileTextField(profileController.nameController,
                          "Can we know your name?", TextInputType.name)),
                ),
                Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.018),
                    child: labelName(context, "Mobile No.")),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: getH(context) * 0.005),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: authController.phoneNo.value,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: ColorConst.titleColor, fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade200, fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                        ),
                        onChanged: (val) {},
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.018),
                    child: labelName(context, "Age")),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: getH(context) * 0.005),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: profileTextField(profileController.ageController,
                          "Can we know your age?", TextInputType.number)),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    EdgeInsets.only(top: getH(context) * 0.02),
                                child: labelName(context, "Weight")),
                            SizedBox(
                              height: getH(context) * 0.004,
                            ),
                            TextFormField(
                              controller: profileController.weightController,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: authController.isDarkMode.value
                                      ? Colors.white
                                      : ColorConst.titleColor),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                hintText: "--",
                                hintStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConst.borderColor),
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConst.borderColor),
                                    borderRadius: BorderRadius.circular(8)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConst.borderColor),
                                    borderRadius: BorderRadius.circular(8)),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: ToggleButtons(
                                    constraints: const BoxConstraints(
                                        maxHeight: 40,
                                        minHeight: 35,
                                        minWidth: 40),
                                    isSelected: [
                                      profileController.weightdim.value,
                                      !profileController.weightdim.value
                                    ],
                                    onPressed: (int index) {
                                      profileController.weightdim.value =
                                          index == 0;
                                    },
                                    highlightColor: Colors.red,
                                    borderColor: Colors.white12,
                                    renderBorder: false,
                                    color: Colors.black,
                                    selectedColor: Colors.white,
                                    fillColor: ColorConst.websiteHomeBox,
                                    borderRadius: BorderRadius.circular(8),
                                    children: const <Widget>[
                                      Text('kg'),
                                      Text('lbs'),
                                    ],
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: getW(context) * 0.12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    EdgeInsets.only(top: getH(context) * 0.02),
                                child: labelName(context, "Height")),
                            SizedBox(
                              height: getH(context) * 0.004,
                            ),
                            TextFormField(
                              controller: profileController.heightController,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: authController.isDarkMode.value
                                      ? Colors.white
                                      : ColorConst.titleColor),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                hintText: "--",
                                hintStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConst.borderColor),
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConst.borderColor),
                                    borderRadius: BorderRadius.circular(8)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConst.borderColor),
                                    borderRadius: BorderRadius.circular(8)),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: ToggleButtons(
                                    constraints: const BoxConstraints(
                                        maxHeight: 40,
                                        minHeight: 35,
                                        minWidth: 40),
                                    isSelected: [
                                      profileController.heightdim.value,
                                      !profileController.heightdim.value
                                    ],
                                    onPressed: (int index) {
                                      profileController.heightdim.value =
                                          index == 0;
                                    },
                                    highlightColor: Colors.red,
                                    borderColor: Colors.white12,
                                    renderBorder: false,
                                    color: Colors.black,
                                    selectedColor: Colors.white,
                                    fillColor: ColorConst.websiteHomeBox,
                                    borderRadius: BorderRadius.circular(8),
                                    children: const <Widget>[
                                      Text('in'),
                                      Text('cm'),
                                    ],
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getH(context) * 0.025,
                ),
                Obx(
                  () => Center(
                    child: submitBtn(
                        context,
                        profileController.isLoading.value
                            ? "Please wait.."
                            : "Update profile", () async {
                      if (profileController.pickedImage.isNotEmpty) {
                        await uploadImageToS3(profileController.pickedImage);
                      }
                      await profileController.editProfile();
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
