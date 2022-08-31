import 'package:english_word_800/binding/app_binding.dart';
import 'package:english_word_800/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart/app_controller.dart';
import 'theme/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '초등 영단어 800',
        themeMode: controller.darkMode.value ? ThemeMode.dark : ThemeMode.light,
        darkTheme: Themes.dark,
        theme: Themes.light,
        initialBinding: AppBinding(),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => Home()),
        ],
      ),
    );
  }
}
