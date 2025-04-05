import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.height = 56,
    this.isBorder = false,
    this.color = kPrimaryColor,
    this.iswhite = false,
    this.width = 343,
  });
  final String title;
  final VoidCallback onTap;
  final double height;
  final bool iswhite;
  final Color color;
  final bool isBorder;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border:
                isBorder ? Border.all(width: 1.w, color: kPrimaryColor) : null),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: iswhite ? Colors.black : Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                letterSpacing: 0 / 100),
          ),
        ),
      ),
    );
  }
}
