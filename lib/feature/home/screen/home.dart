import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/app_texts.dart';
import 'package:sportyo/core/const/icons_path.dart';
import 'package:sportyo/feature/event/screen/event.dart';

import '../../chat/screen/chats_list_screen.dart';
import '../../profile/screen/profile_view.dart';
import '../../search/screen/search_screen.dart';
import '../controller/home_controller.dart';

class Home extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  Home({super.key});

  final List<Widget> navBody = [
    const ProfileView(),
    const SearchScreen(),
    Event(),
    const ChatsListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => navBody.elementAt(homeController.currentNavIndex.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: homeController.currentNavIndex.value,
          selectedItemColor: AppColors.blackColor,
          unselectedItemColor: AppColors.lightBlack,
          selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 8,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 8,
          ),
          backgroundColor: AppColors.whiteColor,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset(
                  homeController.currentNavIndex.value == 0
                      ? IconsPath.sprofile
                      : IconsPath.profile,
                  width: 16,
                  height: 16,
                  color: homeController.currentNavIndex.value == 0
                      ? AppColors.blackColor
                      : AppColors.lightBlack,
                ),
              ),
              label: AppTexts.profile,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset(
                  homeController.currentNavIndex.value == 1
                      ? IconsPath.ssearch
                      : IconsPath.search,
                  width: 16,
                  height: 16,
                  color: homeController.currentNavIndex.value == 1
                      ? AppColors.blackColor
                      : AppColors.lightBlack,
                ),
              ),
              label: AppTexts.search,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset(
                  homeController.currentNavIndex.value == 2
                      ? IconsPath.sevents
                      : IconsPath.events,
                  width: 16,
                  height: 16,
                  color: homeController.currentNavIndex.value == 2
                      ? AppColors.blackColor
                      : AppColors.lightBlack,
                ),
              ),
              label: AppTexts.events,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset(
                  homeController.currentNavIndex.value == 3
                      ? IconsPath.schats
                      : IconsPath.chats,
                  width: 16,
                  height: 16,
                  color: homeController.currentNavIndex.value == 3
                      ? AppColors.blackColor
                      : AppColors.lightBlack,
                ),
              ),
              label: AppTexts.chats,
            ),
          ],
          onTap: homeController.changeNavIndex,
        ),
      ),
    );
  }
}
