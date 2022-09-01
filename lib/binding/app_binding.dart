import 'package:english_word_800/controller.dart/ads_home_controller.dart';
import 'package:english_word_800/controller.dart/app_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(AdsHomeController());
  }
}
