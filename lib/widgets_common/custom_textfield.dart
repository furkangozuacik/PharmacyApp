import 'package:pharmacy/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextField({
  String? title,
  String? hint,
  controller,
  isPass
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            hintStyle:const TextStyle(fontFamily: semibold, color: textfieldGrey),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder:
               const OutlineInputBorder(borderSide: BorderSide(color: redColor))),
      ),
      5.heightBox,
    ],
  );
}
