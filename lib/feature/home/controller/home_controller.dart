import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }
}
