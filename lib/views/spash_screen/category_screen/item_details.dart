import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/images.dart';
import 'package:pharmacy/consts/lists.dart';
import 'package:pharmacy/consts/strings.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/controller/product_controller.dart';
import 'package:pharmacy/views/spash_screen/chat_screen/seller_chat_screen.dart';
import 'package:pharmacy/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({super.key, this.title, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
          backgroundColor: lightGrey,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                ),
              ),
              Obx(
                () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishList(data.id, context);
                    } else {
                      controller.addToWishList(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  ),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //swiper
                          VxSwiper.builder(
                              autoPlay: true,
                              height: 350,
                              itemCount: data['p_imgs'].length,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  data['p_imgs'][index],
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
                            isSelectable: false,
                            value: double.parse(data["p_rating"]),
                            onRatingUpdate: (value) {},
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            count: 5,
                            size: 25,
                            maxRating: 5,
                          ),
                          10.heightBox,
                          "${data['p_price']}"
                              .numCurrencyWithLocale(locale: "tr_TR")
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
                                  "seller"
                                      .text
                                      .white
                                      .fontFamily(semibold)
                                      .make(),
                                  5.heightBox,
                                  "${data['p_seller']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .size(16)
                                      .make()
                                ],
                              )),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.message_rounded,
                                  color: darkFontGrey,
                                ),
                              ).onTap(() {
                                Get.to(() => const SellerChatScreen(),
                                    arguments: [
                                      data["p_seller"],
                                      data["vendor_id"]
                                    ]);
                              })
                            ],
                          )
                              .box
                              .height(60)
                              .padding(
                                  const EdgeInsets.symmetric(horizontal: 16))
                              .color(textfieldGrey)
                              .make(),
                          //color section
                          20.heightBox,
                          Obx(
                            () => Column(
                              children: [
                                //quantity section

                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Quantity: "
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ),
                                    Obx(
                                      () => Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                controller.decreaseQuantity();
                                                controller.calculateTotalPrice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: const Icon(Icons.remove)),
                                          controller.quantity.value.text
                                              .size(16)
                                              .color(darkFontGrey)
                                              .fontFamily(bold)
                                              .make(),
                                          IconButton(
                                              onPressed: () {
                                                controller.increaseQuantity(
                                                    int.parse(
                                                        data['p_quantity']));
                                                controller.calculateTotalPrice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: const Icon(Icons.add)),
                                          10.widthBox,
                                          "(${data['p_quantity']} avaliable)"
                                              .text
                                              .color(textfieldGrey)
                                              .make()
                                        ],
                                      ),
                                    ),
                                  ],
                                ).box.padding(const EdgeInsets.all(8)).make(),

                                //total section

                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: "Total:"
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ),
                                    "${controller.totalPrice.value}"
                                        .numCurrencyWithLocale(locale: "tr_TR")
                                        .text
                                        .color(redColor)
                                        .size(16)
                                        .fontFamily(bold)
                                        .make()
                                  ],
                                ).box.padding(const EdgeInsets.all(8)).make()
                              ],
                            ).box.white.shadowSm.make(),
                          ),
                          //decription section
                          10.heightBox,
                          "Description"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          "${data['p_desc']}".text.color(darkFontGrey).make(),
                          10.heightBox,
                          //buttons
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                                itemDetailButtonList.length,
                                (index) => ListTile(
                                      title: itemDetailButtonList[index]
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      trailing: const Icon(Icons.arrow_forward),
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
                                    4,
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
                                            "Ağrı Kesici"
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
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .padding(const EdgeInsets.all(8))
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
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                          color: data["p_colors"][controller.colorIndex.value],
                          context: context,
                          vendorID: data["vendor_id"],
                          img: data["p_imgs"][0],
                          qty: controller.quantity.value,
                          sellername: data["p_seller"],
                          title: data["p_name"],
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Added to cart");
                    } else {
                      VxToast.show(context,
                          msg: "Minimum 1 product is required");
                    }
                  },
                  textColor: whiteColor,
                  title: "add to cart",
                ),
              )
            ],
          )),
    );
  }
}
