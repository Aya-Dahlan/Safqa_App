import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/utils/app_icons.dart';

class memberWiget extends StatelessWidget {
  const memberWiget({super.key, required this.icon, required this.title});
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        SizedBox(
          width: 16.w,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300,
              letterSpacing: 0 / 100),
        )
      ],
    );
  }
}
