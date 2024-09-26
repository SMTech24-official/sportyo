import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/controller_binder/controller_binder.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/app_texts.dart';
import 'package:sportyo/feature/authentication/log_in/screen/log_in.dart';
import 'package:get/get.dart';

class Sprotyo extends StatelessWidget {
  const Sprotyo({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 905),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          initialBinding: ControllerBinder(),
          debugShowCheckedModeBanner: false,
          title: AppTexts.appName,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: AppColors.whiteColor,
                centerTitle: true,
                titleTextStyle: GoogleFonts.sourceSans3(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    height: 40.sp / 28.sp,
                    color: AppColors.blackColor)),
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
          home: child,
          builder: EasyLoading.init(),
        );
      },
      child: LogIn(),
    );
  }
}
