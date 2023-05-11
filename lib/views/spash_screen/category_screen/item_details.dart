import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/images.dart';
import 'package:pharmacy/consts/lists.dart';
import 'package:pharmacy/consts/strings.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //swiper
                        VxSwiper.builder(
                            autoPlay: true,
                            height: 350,
                            itemCount: 3,
                            aspectRatio: 16 / 9,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                imgFc5,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            }),
                        10.heightBox,
                        //title and details
                        title!.text
                            .size(16)
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        //rating
                        VxRating(
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          size: 25,
                          stepInt: true,
                        ),
                        10.heightBox,
                        "\$30"
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "seller".text.white.fontFamily(semibold).make(),
                                5.heightBox,
                                "in house brands"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .size(16)
                                    .make()
                              ],
                            )),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.message_rounded,
                                color: darkFontGrey,
                              ),
                            )
                          ],
                        )
                            .box
                            .height(60)
                            .padding(EdgeInsets.symmetric(horizontal: 16))
                            .color(textfieldGrey)
                            .make(),
                        //color section
                        20.heightBox,
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "color:".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                      3,
                                      (index) => VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Vx.randomPrimaryColor)
                                          .margin(EdgeInsets.symmetric(
                                              horizontal: 6))
                                          .make()),
                                )
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),

                            //quantity section

                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "color:".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.remove)),
                                    "0"
                                        .text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.add)),
                                    10.widthBox,
                                    "(0 avaliable)"
                                        .text
                                        .color(textfieldGrey)
                                        .make()
                                  ],
                                ),
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),

                            //total section

                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "Total:".text.color(textfieldGrey).make(),
                                ),
                                "\$0.00"
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make()
                              ],
                            ).box.padding(EdgeInsets.all(8)).make()
                          ],
                        ).box.white.shadowSm.make(),
                        //decription section
                        10.heightBox,
                        "Description"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        "This is a dummy item and dummy description here..."
                            .text
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        //buttons
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              itemDetailButtonList.length,
                              (index) => ListTile(
                                    title: "${itemDetailButtonList[index]}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    trailing: Icon(Icons.arrow_forward),
                                  )),
                        ),
                        20.heightBox,
                        //products may like section
                        productsyoumaylike.text
                            .fontFamily(bold)
                            .size(16)
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  6,
                                  (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            imgP1,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
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
                                          .margin(EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .padding(EdgeInsets.all(8))
                                          .make())),
                        )
                      ]
                      //our details ui completed.
                      ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: redColor,
                onPress: () {},
                textColor: whiteColor,
                title: "add to cart",
              ),
            )
          ],
        ));
  }
}
