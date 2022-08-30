import 'package:get/get.dart';

import '../db/db_helper.dart';

class AppController extends GetxController {
  final db = DbHelper();
  List menus = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  void onInit() {
    super.onInit();
    getCount();
  }

  RxBool darkMode = true.obs;
  var words = [].obs;
  var filterdWords = [].obs;
  RxInt addcount = 0.obs;

  void changeTheme() {
    darkMode(!darkMode.value);
  }

  void getWords(String title) async {
    final data = await db.getAllItems();
    var output = data.where((e) => e.title == title).toList();
    words(output);
  }

  void getCount() async {
    final data = await db.getAllItems();
    var addItem = data.where((e) => e.adding == 1).toList();
    filterdWords(addItem);
    addcount.value = addItem.length;
  }

  void toggleShow(int id, int showing, String title) async {
    if (showing == 1) {
      await db.updateShow(id, 0);
    } else {
      await db.updateShow(id, 1);
    }
    getWords(title);
    getCount();
  }

  void toggleAdd(int id, int adding, String title) async {
    if (adding == 1) {
      await db.updateAdd(id, 0);
    } else {
      await db.updateAdd(id, 1);
    }
    getWords(title);
    getCount();
  }
}
