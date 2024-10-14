import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  PageController pageController = PageController();

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    currentNavIndex.value = index;
  }
}
