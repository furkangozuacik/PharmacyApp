import 'package:pharmacy/consts/consts.dart';
import 'package:pharmacy/consts/lists.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/controller/auth_controller.dart';
import 'package:pharmacy/views/spash_screen/applogo_widget.dart';
import 'package:pharmacy/views/spash_screen/auth_screen/signup_screen.dart';
import 'package:pharmacy/views/spash_screen/home_screen/home.dart';
import 'package:pharmacy/widgets_common/bg_widget.dart';
import 'package:pharmacy/widgets_common/custom_textField.dart';
import 'package:pharmacy/widgets_common/our_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../consts/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    hint: emailHint,
                    title: email,
                    isPass: false,
                    controller: controller.emailController),
                customTextField(
                    hint: password,
                    title: password,
                    isPass: true,
                    controller: controller.passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPassword.text.make())),
                5.heightBox,
                controller.isloading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : ourButton(
                        color: redColor,
                        title: login,
                        textColor: whiteColor,
                        onPress: () async {
                          controller.isloading(true);

                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(() => const Home());
                            } else {
                              controller.isloading(false);
                            }
                          });
                        }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                    color: lightGolden,
                    title: signup,
                    textColor: redColor,
                    onPress: () {
                      Get.to(() => SignupScreen());
                    }).box.width(context.screenWidth - 90).make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            )))
              ],
            )
                .box
                .white
                .rounded
                .padding(EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .make(),
          ),
        ]),
      ),
    ));
  }
}
