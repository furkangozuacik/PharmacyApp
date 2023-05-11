import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/consts.dart';
import 'package:pharmacy/consts/images.dart';
import 'package:pharmacy/controller/profile_controller.dart';
import 'package:pharmacy/widgets_common/bg_widget.dart';
import 'package:pharmacy/widgets_common/custom_textfield.dart';
import 'package:pharmacy/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 130,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : Image.file(
                    File(controller.profileImgPath.value),
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            Divider(),
            20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            customTextField(
                controller: controller.passController,
                hint: passwordHint,
                title: password,
                isPass: false),
            20.heightBox,
            SizedBox(
              width: context.screenWidth - 60,
              child: ourButton(
                  color: redColor,
                  onPress: () async {
                    controller.isLoading(true);
                    await controller.uploadProfileImage();
                    await controller.updateProfile(
                        imgUrl: controller.profileImageLink,
                        name: controller.nameController.text,
                        password: controller.passController.text);
                  },
                  textColor: whiteColor,
                  title: "Save"),
            ),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(EdgeInsets.all(16))
            .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
