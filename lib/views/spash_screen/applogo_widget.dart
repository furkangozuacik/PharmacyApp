import "package:pharmacy/consts/consts.dart";
import "package:flutter/widgets.dart";
import "package:pharmacy/consts/images.dart";
import "package:velocity_x/velocity_x.dart";

Widget applogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(EdgeInsets.all(8))
      .rounded
      .make();
}
