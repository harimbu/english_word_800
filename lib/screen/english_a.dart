import 'package:badges/badges.dart';
import 'package:english_word_800/controller.dart/app_controller.dart';
import 'package:english_word_800/screen/book.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnglishA extends StatefulWidget {
  final String title;
  EnglishA({Key? key, required this.title}) : super(key: key);

  @override
  State<EnglishA> createState() => _EnglishAState();
}

class _EnglishAState extends State<EnglishA> {
  final FlutterTts tts = FlutterTts();
  final controller = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    initSpeak();
    controller.getWords(widget.title);
  }

  initSpeak() async {
    await tts.setLanguage('en');
    await tts.setSpeechRate(0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineLarge,
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
        ),
        body: ListView.builder(
          itemCount: controller.words.length,
          itemBuilder: (_, index) {
            final item = controller.words[index];

            return Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.toggleShow(
                          item.id, item.showing, widget.title);
                    },
                    icon: Image.asset(
                      item.showing == 1
                          ? 'assets/img/check-on.png'
                          : controller.darkMode.value
                              ? 'assets/img/check-dark.png'
                              : 'assets/img/check-light.png',
                      width: 18,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => tts.speak(item.eng),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                item.eng,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 6),
                            ],
                          ),
                          item.showing == 1
                              ? Text(
                                  item.kor,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.toggleAdd(item.id, item.adding, widget.title);
                    },
                    icon: Image.asset(
                      item.adding == 1
                          ? 'assets/img/plus-on.png'
                          : 'assets/img/plus.png',
                      width: 18,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
