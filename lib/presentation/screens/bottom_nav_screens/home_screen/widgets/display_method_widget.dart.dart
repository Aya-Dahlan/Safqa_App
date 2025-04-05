import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/utils/app_icons.dart';

class DisplayMethodWidget extends StatelessWidget {
  final bool isGridView;
  final VoidCallback onTap;

  const DisplayMethodWidget(
      {super.key, required this.isGridView, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // يتم التحكم بالحالة من الصفحة الرئيسية
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xffF6FAFD),
        ),
        child: Center(
          child: SvgPicture.asset(
            isGridView ? AppIcons.horizant : AppIcons.vertical,
          ),
        ),
      ),
    );
  }
}
