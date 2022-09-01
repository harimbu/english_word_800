import 'package:badges/badges.dart';
import 'package:english_word_800/controller.dart/ads_controller.dart';
import 'package:english_word_800/screen/book.dart';
import 'package:english_word_800/screen/english.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controller.dart/app_controller.dart';
import '../theme/themes.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final controller = Get.find<AppController>();
  final adcontroller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/img/logo.png',
                    width: 40,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '영단어 800',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.changeTheme();
              },
              icon: Image.asset(
                controller.darkMode.value
                    ? 'assets/img/sun.png'
                    : 'assets/img/moon.png',
                width: 24,
              ),
            ),
            InkWell(
              onTap: () => Get.to(() => Book()),
              child: Badge(
                position: BadgePosition(top: 14.0, start: 12.0),
                badgeContent: Text(
                  controller.addcount.value.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                child: Image.asset(
                  controller.darkMode.value
                      ? 'assets/img/book-dark.png'
                      : 'assets/img/book.png',
                  width: 24,
                ),
              ),
            ),
            SizedBox(width: 26),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(38, 20, 38, 10),
                child: GridView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.menus.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1 / 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => English(title: controller.menus[index]));
                      },
                      child: Container(
                        color: controller.darkMode.value
                            ? Themes.darkBg1
                            : Themes.bg3,
                        child: Center(
                          child: Text(
                            controller.menus[index],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (adcontroller.staticAdLoaded.value)
              Container(
                width: adcontroller.staticAd.size.width.toDouble(),
                height: adcontroller.staticAd.size.height.toDouble(),
                alignment: Alignment.bottomCenter,
                child: AdWidget(
                  ad: adcontroller.staticAd,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
