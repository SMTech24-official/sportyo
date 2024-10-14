import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller_binder/controller_binder.dart';
import 'core/const/app_colors.dart';
import 'core/const/app_texts.dart';
import 'feature/authentication/auth_service/auth_service.dart';
import 'feature/authentication/log_in/screen/log_in.dart';
import 'feature/home/screen/home.dart';
import 'feature/profile/screen/profile_edit.dart';
import 'feature/splash_screen/controller/splash_screen_controller.dart';
import 'feature/splash_screen/screen/splash_screen.dart';

class Sprotyo extends StatefulWidget {
  const Sprotyo({super.key});

  @override
  State<Sprotyo> createState() => _SprotyoState();
}

class _SprotyoState extends State<Sprotyo> {
  final SplashController controllerProfile = Get.put(SplashController());
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    await Future.delayed(const Duration(seconds: 1));
    bool hasToken = await AuthService.hasToken();

    if (hasToken) {
      controllerProfile.fetchUserData().then((value) async {
        if ((controllerProfile.userModel.value.firstName?.isEmpty ?? true) &&
            (controllerProfile.userModel.value.sportsDetails.isEmpty)) {
          Get.offAll(() => const ProfileViewScreen());
        } else {
          Get.offAll(() => Home());
        }
      });
    } else {
      Get.offAll(() => const LogIn());
    }

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 905),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          initialBinding: ControllerBinder(),
          debugShowCheckedModeBanner: false,
          title: AppTexts.appName,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.whiteColor,
              centerTitle: true,
              titleTextStyle: GoogleFonts.poppins(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
                height: 40.sp / 28.sp,
                color: AppColors.blackColor,
              ),
            ),
            scaffoldBackgroundColor: AppColors.whiteColor,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          home: const SplashScreen(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
