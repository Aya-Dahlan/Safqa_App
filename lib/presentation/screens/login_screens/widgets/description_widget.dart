import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class descriptionWidget extends StatelessWidget {
  const descriptionWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.w,
      child: Text(
        text,
        style: TextStyle(
            color: const Color(0xffABB3C8),
            fontWeight: FontWeight.w300,
            fontSize: 16.sp,
            height: 24 / 16,
            letterSpacing: 0 / 100),
      ),
    );
  }
}
