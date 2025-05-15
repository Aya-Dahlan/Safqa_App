import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconWidget extends StatelessWidget {
  const IconWidget(
      {super.key,
      required this.icon,
      required this.isRect,
      required this.onPressed});
  final Widget icon;
  final bool isRect;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 28.w,
        height: 28.h,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: isRect ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: isRect ? BorderRadius.circular(8) : null,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
