import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppTexts.appName,
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bottomColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            primarySwatch: Colors.blue,
          ),
          home: child,
        );
      },
      child:  LogIn(),
    );
  }
}

