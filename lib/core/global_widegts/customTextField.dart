import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hitText,
    required this.textEditingController,
     this.fontSize,
     this.fontWeight,
     this.lineHeight,

  });
  final String? hitText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      width: 273.w,
      child: TextField(
        controller: textEditingController,
        style: GoogleFonts.sourceSans3(

            fontSize:fontSize?? 16.sp,
            fontWeight: fontWeight??FontWeight.w400,
            height:lineHeight?? 24.h / 16.h,
            color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: hitText,

          hintStyle: GoogleFonts.sourceSans3(
              fontSize:fontSize?? 16.sp,
              fontWeight: fontWeight??FontWeight.w400,
              height:lineHeight?? 24.h / 16.h,
              color: AppColors.blackColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xff010101), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xff010101), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xff010101), width: 1),
          ),

        ),
      ),
    );
  }
}
