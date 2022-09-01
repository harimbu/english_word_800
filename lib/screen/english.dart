import 'package:badges/badges.dart';
import 'package:english_word_800/controller.dart/ad_controller.dart';
import 'package:english_word_800/controller.dart/app_controller.dart';
import 'package:english_word_800/screen/book.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

const int maxAttempts = 3;

class English extends StatefulWidget {
  final String title;
  English({Key? key, required this.title}) : super(key: key);

  @override
  State<English> createState() => _EnglishState();
}

class _EnglishState extends State<English> {
  final FlutterTts tts = FlutterTts();
  final controller = Get.find<AppController>();
  final adController = Get.find<Adcontroller>();

  void initSpeak() async {
    await tts.setLanguage('en');
    await tts.setSpeechRate(0.4);
  }

  @override
  void initState() {
    super.initState();
    initSpeak();
    controller.getWords(widget.title);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  // appbar
  _appBar() {
    return AppBar(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      actions: [
        IconButton(
          onPressed: () => controller.changeTheme(),
          icon: Image.asset(
            controller.darkMode.value
                ? 'assets/img/sun.png'
                : 'assets/img/moon.png',
            width: 24,
          ),
        ),
        InkWell(
          onTap: () => Get.to(() => Book(), arguments: widget.title),
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
    );
  }

  // body
  _body() {
    if (controller.words.isEmpty) {
      return Center(
        child: Text(
          '단어가 없습니다.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.words.length,
              itemBuilder: (_, index) {
                return Container(
                  child: _list(item: controller.words[index]),
                );
              },
            ),
          ),
          if (adController.staticAdLoaded.value)
            Container(
              width: adController.staticAd.size.width.toDouble(),
              height: adController.staticAd.size.height.toDouble(),
              alignment: Alignment.bottomCenter,
              child: AdWidget(
                ad: adController.staticAd,
              ),
            ),
        ],
      );
    }
  }

  _list({required item}) {
    return ListTile(
      minLeadingWidth: 24,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () =>
                  controller.toggleShow(item.id, item.showing, widget.title),
              icon: Image.asset(
                item.showing == 1
                    ? 'assets/img/check-on.png'
                    : controller.darkMode.value
                        ? 'assets/img/check-dark.png'
                        : 'assets/img/check-light.png',
                width: 18,
              )),
        ],
      ),
      title: InkWell(
        onTap: () => tts.speak(item.eng),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.eng, style: Theme.of(context).textTheme.bodyLarge),
              item.showing == 1
                  ? Column(
                      children: [
                        SizedBox(height: 8),
                        Text(
                          item.kor,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      trailing: IconButton(
        onPressed: () =>
            controller.toggleAdd(item.id, item.adding, widget.title),
        icon: Image.asset(
          item.adding == 1 ? 'assets/img/plus-on.png' : 'assets/img/plus.png',
          width: 18,
        ),
      ),
    );
  }
  // body end
}
