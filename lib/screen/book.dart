import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../controller.dart/app_controller.dart';
import '../theme/themes.dart';

class Book extends StatefulWidget {
  Book({Key? key}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  final controller = Get.find<AppController>();
  final FlutterTts tts = FlutterTts();
  final title = Get.arguments ?? '';

  initSpeak() async {
    await tts.setLanguage('en');
    await tts.setSpeechRate(0.4);
  }

  @override
  void initState() {
    super.initState();
    initSpeak();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            '단어장',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            Badge(
              position: BadgePosition(top: 28.0, start: 0.0),
              badgeContent: Text(
                controller.addcount.value.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              child: SizedBox(
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(width: 26),
          ],
        ),
        body: ListView.builder(
          itemCount: controller.filterdWords.length,
          itemBuilder: (_, index) {
            final item = controller.filterdWords[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                tileColor:
                    controller.darkMode.value ? Themes.darkBg1 : Themes.bg3,
                minLeadingWidth: 24,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.toggleShow(item.id, item.showing, title);
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
                  ],
                ),
                title: InkWell(
                  onTap: () {
                    tts.speak(item.eng);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.eng,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        item.showing == 0
                            ? Container()
                            : Column(
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    item.kor,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    controller.toggleAdd(item.id, item.adding, title);
                  },
                  icon: Image.asset(
                    'assets/img/plus-on.png',
                    width: 18,
                    height: 18,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
