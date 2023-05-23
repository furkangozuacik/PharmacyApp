// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pharmacy/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/consts/images.dart';

import 'package:pharmacy/consts/lists.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/controller/auth_controller.dart';
import 'package:pharmacy/controller/home_controller.dart';
import 'package:pharmacy/controller/product_controller.dart';
import 'package:pharmacy/services/firestore_services.dart';
import 'package:pharmacy/views/barcode_screen/barcode_screen.dart';
import 'package:pharmacy/views/near_pharmacies_screen/pharmacies_screen.dart';
import 'package:pharmacy/views/spash_screen/applogo_widget.dart';
import 'package:pharmacy/views/spash_screen/auth_screen/login_screen.dart';
import 'package:pharmacy/views/spash_screen/category_screen/category_screen.dart';
import 'package:pharmacy/views/spash_screen/category_screen/item_details.dart';
import 'package:pharmacy/views/spash_screen/chatscreen.dart';
import 'package:pharmacy/views/spash_screen/home_screen/components/featured_button.dart';
import 'package:pharmacy/views/spash_screen/home_screen/search_screen.dart';
import 'package:pharmacy/views/spash_screen/profile_screen/profile_screen.dart';
import 'package:pharmacy/widgets_common/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../consts/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    var catController = Get.put(ProductController());
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: redColor,
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  child: applogoWidget(),
                )),
            50.heightBox,
            ListTile(
              leading: const Icon(
                Icons
                    .location_on_outlined, // İstediğiniz simgeyi burada belirtebilirsiniz
                size: 30,
                color: darkFontGrey,
              ),
              title: 'Nearby Pharmacies'
                  .text
                  .fontFamily(bold)
                  .size(22)
                  .color(darkFontGrey)
                  .make(),
              onTap: () {
                Get.to(const NearPharmaciesScreen());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons
                    .qr_code_scanner_outlined, // İstediğiniz simgeyi burada belirtebilirsiniz
                size: 30,
                color: darkFontGrey,
              ),
              title: 'Barcode Scanner'
                  .text
                  .fontFamily(bold)
                  .size(22)
                  .color(darkFontGrey)
                  .make(),
              onTap: () {
                Get.to(const QRScanner());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons
                    .category_sharp, // İstediğiniz simgeyi burada belirtebilirsiniz
                size: 30,
                color: darkFontGrey,
              ),
              title: 'Categories'
                  .text
                  .fontFamily(bold)
                  .size(22)
                  .color(darkFontGrey)
                  .make(),
              onTap: () {
                Get.to(const CategoryScreen());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons
                    .account_circle_outlined, // İstediğiniz simgeyi burada belirtebilirsiniz
                size: 30,
                color: darkFontGrey,
              ),
              title: 'My Account'
                  .text
                  .fontFamily(bold)
                  .size(22)
                  .color(darkFontGrey)
                  .make(),
              onTap: () {
                Get.to(const ProfileScreen());
              },
            ),
            100.heightBox,
            ListTile(
              leading: const Icon(
                Icons
                    .logout_outlined, // İstediğiniz simgeyi burada belirtebilirsiniz
                size: 30,
                color: darkFontGrey,
              ),
              onTap: () async {
                await Get.put(AuthController()).signoutMethod(context: context);
                Get.offAll(() => const LoginScreen());
              },
              title: 'Log out'
                  .text
                  .fontFamily(bold)
                  .size(22)
                  .color(darkFontGrey)
                  .make(),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
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
                controller: controller.searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.search).onTap(() {
                      if (controller
                          .searchController.text.isNotEmptyAndNotNull) {
                        Get.to(() => SearchScreen(
                              title: controller.searchController.text,
                            ));
                      }
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchanything,
                    hintStyle: const TextStyle(color: textfieldGrey)),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    10.heightBox,

                    //2nd slider
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 250,
                        enlargeCenterPage: true,
                        itemCount: secondSliderList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              switch (index) {
                                case 1:
                                  Get.to(() => const QRScanner());
                                  break;
                                case 2:
                                  Get.to(() => const NearPharmaciesScreen());
                                  break;
                                case 3:
                                  Get.to(() => const ChatScreen());
                                  break;
                                default:
                              }
                            },
                            child: Image.asset(secondSliderList[index],
                                    fit: BoxFit.fitWidth)
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make(),
                          );
                        }),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(22)
                          .fontFamily(semibold)
                          .make(),
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                        icon: featuredImages1[index],
                                        title: featuredTitles1[index]),
                                    10.heightBox,
                                    featuredButton(
                                        icon: featuredImages2[index],
                                        title: featuredTitles2[index])
                                  ],
                                )).toList(),
                      ),
                    ),
                    //featured product

                    20.heightBox,

                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white
                                .fontFamily(bold)
                                .size(18)
                                .make(),
                            10.heightBox,
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FutureBuilder(
                                    future:
                                        FireStoreServices.getFeaturedProducst(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: loadingIndicator(),
                                        );
                                      } else if (snapshot.data!.docs.isEmpty) {
                                        return "No featured products"
                                            .text
                                            .white
                                            .makeCentered();
                                      } else {
                                        var featuredData = snapshot.data!.docs;
                                        return Row(
                                            children: List.generate(
                                                featuredData.length,
                                                (index) => Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.network(
                                                          featuredData[index]
                                                              ["p_imgs"][0],
                                                          width: 130,
                                                          height: 130,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        10.heightBox,
                                                        "${featuredData[index]["p_name"]}"
                                                            .text
                                                            .fontFamily(
                                                                semibold)
                                                            .color(darkFontGrey)
                                                            .make(),
                                                        10.heightBox,
                                                        "${featuredData[index]["p_price"]}"
                                                            .numCurrencyWithLocale(
                                                                locale: "tr_TR")
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
                                                        .margin(const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 4))
                                                        .padding(
                                                            const EdgeInsets
                                                                .all(8))
                                                        .make()
                                                        .onTap(() {
                                                      Get.to(() => ItemDetails(
                                                          data: featuredData[
                                                              index],
                                                          title:
                                                              "${featuredData[index]['p_name']}"));
                                                    })));
                                      }
                                    }))
                          ]),
                    ),
                    20.heightBox,
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
