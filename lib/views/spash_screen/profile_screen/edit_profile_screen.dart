// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';

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
            //buradaki bişileri silmesi lazım
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
            const Divider(),
            20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            10.heightBox,
            customTextField(
                controller: controller.oldpassController,
                hint: passwordHint,
                title: "Password",
                isPass: false),
            10.heightBox,
            customTextField(
                controller: controller.newpassController,
                hint: passwordHint,
                title: "Retype Password",
                isPass: false),
            10.heightBox,
            SizedBox(
              width: context.screenWidth - 60,
              child: ourButton(
                  color: redColor,
                  onPress: () async {
                    controller.isLoading(true);
                    //if image is not selected
                    if (controller.profileImgPath.value.isNotEmpty) {
                      await controller.uploadProfileImage();
                    } else {
                      controller.profileImageLink = data["imageUrl"];
                    }
                    //if old password matches data base
                    if (data["password"] == controller.oldpassController.text) {
                      await controller.changeAuthPassword(
                          email: data["email"],
                          password: controller.oldpassController.text,
                          newpassword: controller.newpassController.text);

                      await controller.updateProfile(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          password: controller.newpassController.text);
                      VxToast.show(context, msg: "updated");
                    } else {
                      VxToast.show(context, msg: "Wrong old password");
                      controller.isLoading(false);
                    }
                  },
                  textColor: whiteColor,
                  title: "Save"),
            ),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
