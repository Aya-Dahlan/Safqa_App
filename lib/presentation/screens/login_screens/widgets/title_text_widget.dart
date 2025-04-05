import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class titleTextWidget extends StatelessWidget {
  const titleTextWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xff0C0B19),
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0 / 100,
      ),
    );
  }
}
