import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/utils/app_icons.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget(
      {super.key, this.title = 'ابحث عن المنتج', this.width = 283});
  final String title;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: 44.h,
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12.h, bottom: 9.h, right: 12.w),
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(AppIcons.search),
              border: InputBorder.none,
              hintText: title,
              hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xffD0D1D2))),
        ),
      ),
    );
  }
}
