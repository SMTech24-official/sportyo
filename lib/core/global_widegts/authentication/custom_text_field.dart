import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/app_colors.dart';

class CustomTextFieldForAuth extends StatefulWidget {
  final String labelText;
  final bool isPasswordField;
  final TextEditingController controller;

  const CustomTextFieldForAuth({
    super.key,
    required this.labelText,
    this.isPasswordField = false,
    required this.controller,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldForAuthState createState() => _CustomTextFieldForAuthState();
}

class _CustomTextFieldForAuthState extends State<CustomTextFieldForAuth> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // Controller added
      obscureText: widget.isPasswordField ? _isObscure : false,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.blackColor,
        ),
      ), // Text color set to black
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColors.blackColor,
          ),
        ), // Label color as grey
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xffe6f0fa), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xffe6f0fa), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xffe6f0fa), width: 2),
        ),
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  color: AppColors.passIcon,
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.labelText} cannot be empty';
        }
        if (widget.labelText == 'Email' &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }
}
