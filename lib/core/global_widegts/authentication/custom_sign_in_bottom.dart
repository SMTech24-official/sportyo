import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSignInButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomSignInButton({
    super.key,
    required this.text,
    required this.imagePath,

    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: 50.h,
          width: 250.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color:const Color(0xffe6f0fa),width: 2), // light border
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 24,
                width: 24,
              ),
              SizedBox(width: 12.w),
              Text(
                text,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color:const Color(0xff97a3ad),
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
