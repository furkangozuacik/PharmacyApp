import 'package:get/get.dart';
import 'package:pharmacy/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pharmacy/consts/images.dart';
import 'package:pharmacy/consts/lists.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/views/spash_screen/chatscreen.dart';
import 'package:pharmacy/views/spash_screen/home_screen/components/featured_button.dart';
import 'package:pharmacy/widgets_common/home_buttons.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../consts/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              //search
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: TextStyle(color: textfieldGrey)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    child: Image.asset(addd),
                    height: 150,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: MaterialButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Text("MHRS"),
                                  Text("Click for hospital appointment"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            child: MaterialButton(
                              onPressed: () => Get.to(ChatScreen()),
                              child: Column(
                                children: [
                                  Icon(Icons.air),
                                  Text("Which doctor should I go to ?"),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                  //2nd slider
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Image.asset(barkod),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredProduct.text
                        .color(darkFontGrey)
                        .size(22)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondSliderList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  20.heightBox,
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          mainAxisExtent: 300),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgP5,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            Spacer(),
                            ",Ağrı Kesici"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "₺ 20.00"
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make()
                          ],
                        )
                            .box
                            .white
                            .rounded
                            .margin(EdgeInsets.symmetric(horizontal: 4))
                            .padding(EdgeInsets.all(12))
                            .make();
                      })
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
