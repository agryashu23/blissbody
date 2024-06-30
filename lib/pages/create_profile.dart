import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/profileController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/pages/mainpage.dart';
import 'package:blissbody_app/services/rest.dart';
import 'package:blissbody_app/widgets/container_widgets.dart';
import 'package:blissbody_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final ProfileController profileController = Get.find<ProfileController>();
  List<String> tabs = ["Male", "Female"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getW(context) * 0.08),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.07),
                    child: Text(
                      "Create Profile",
                      style: TextStyle(
                          color: ColorConst.titleColor,
                          fontSize: getF(context, 28.0),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: getH(context) * 0.05,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      profileController.pickImage(ImageSource.gallery);
                    },
                    child: Center(
                      child: profileController.pickedImage.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage:
                                  MemoryImage(profileController.pickedImage[0]),
                              radius: 50)
                          : CircleAvatar(
                              backgroundColor: ColorConst.primaryGrey,
                              radius: 50,
                              child: Center(
                                child: Icon(Icons.add,
                                    color: Colors.white,
                                    size: getW(context) * 0.1),
                              )),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.04),
                    child: labelName(context, "Name")),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: getH(context) * 0.005),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: profileTextField(
                          profileController.nameController,
                          "Can you let us know your name?",
                          TextInputType.name)),
                ),
                Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.03),
                    child: labelName(context, "Age")),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: getH(context) * 0.005),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: profileTextField(profileController.ageController,
                          "How old are you?", TextInputType.number)),
                ),
                Obx(
                  () => Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: getH(context) * 0.04),
                    child: FlutterToggleTab(
                      width: getW(context) * 0.18,
                      borderRadius: 20,
                      height: 40,
                      icons: const [Icons.male, Icons.female],
                      selectedIndex: profileController.selectedGender.value,
                      selectedBackgroundColors: const [
                        ColorConst.websiteHomeBox,
                      ],
                      unSelectedBackgroundColors: const [
                        ColorConst.primaryGrey
                      ],
                      selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      unSelectedTextStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      labels: tabs,
                      selectedLabelIndex: (index) {
                        profileController.selectedGender.value = index;
                      },
                      isScroll: false,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: getH(context) * 0.14),
                    child: Obx(
                      () => submitBtn(
                          context,
                          profileController.isLoading.value
                              ? "Creating profile..."
                              : "Complete Profile", () async {
                        if (profileController.nameController.text.isEmpty) {
                          showErrorSnackBar(
                              heading: "Error",
                              message: "Please enter name",
                              icon: Icons.warning,
                              color: Colors.white);
                        } else if (profileController
                            .ageController.text.isEmpty) {
                          showErrorSnackBar(
                              heading: "Error",
                              message: "Please enter age",
                              icon: Icons.warning,
                              color: Colors.white);
                        } else if (profileController.pickedImage.isEmpty) {
                          showErrorSnackBar(
                              heading: "Error",
                              message: "Please add an image",
                              icon: Icons.warning,
                              color: Colors.white);
                        } else {
                          await uploadImageToS3(profileController.pickedImage);
                          await profileController.createProfile();
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
