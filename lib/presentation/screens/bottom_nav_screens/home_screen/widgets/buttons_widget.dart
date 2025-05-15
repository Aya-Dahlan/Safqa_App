import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/constants.dart';

class buttonsWidget extends StatelessWidget {
  const buttonsWidget(
      {super.key,
      required this.icoon,
      required this.title,
      required this.isFill,
      required this.onTap});
  final String title;
  final String icoon;
  final bool isFill;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165.w,
        height: 40.h,
        decoration: BoxDecoration(
            color: isFill ? Color(0xffDBEAF9) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border:
                isFill ? null : Border.all(color: kPrimaryColor, width: 0.5.w)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icoon),
              SizedBox(
                width: 4.w,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
