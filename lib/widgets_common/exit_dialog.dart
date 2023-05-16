import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      const Divider(),
      10.heightBox,
      "Are you sure you want to exit?".text.size(16).color(darkFontGrey).make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ourButton(
              color: redColor,
              onPress: () {
                SystemNavigator.pop();
              },
              textColor: whiteColor,
              title: "Yes"),
          ourButton(
              color: redColor,
              onPress: () {
                Navigator.pop(context);
              },
              textColor: whiteColor,
              title: "No")
        ],
      ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make()
    ]),
  );
}
