import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/constants.dart';

class footerWidget extends StatelessWidget {
  const footerWidget(
      {super.key,
      required this.onTap,
      required this.text1,
      required this.text2});

  final String text1;
  final String text2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(
              fontSize: 16.sp,
              color: Color(0xffABB3C8),
              fontWeight: FontWeight.normal,
              letterSpacing: 0 / 100),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: TextStyle(
                fontSize: 16.sp,
                color: kPrimaryColor,
                fontWeight: FontWeight.normal,
                letterSpacing: 0 / 100),
          ),
        ),
      ],
    );
  }
}
