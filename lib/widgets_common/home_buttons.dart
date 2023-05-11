import "package:flutter/material.dart";
import "package:pharmacy/consts/colors.dart";
import "package:pharmacy/consts/consts.dart";
import "package:pharmacy/consts/images.dart";
import "package:pharmacy/consts/styles.dart";
import "package:velocity_x/velocity_x.dart";

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
