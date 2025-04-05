import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_icons.dart';

Widget arrowBackWidget(BuildContext context) => GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.5.w, color: kPrimaryColor),
        ),
        child: Center(
          child: SvgPicture.asset(AppIcons.arrowBack),
        ),
      ),
    );
