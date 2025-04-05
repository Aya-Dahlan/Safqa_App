import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/utils/app_assets.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35.r,
          backgroundImage: const AssetImage(AppAssets.profile),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          'هلا فيكِ آلاء👋',
          style: TextStyle(
            fontSize: 18.sp,
            color: const Color(0xff1A1927),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          'alaabdallah@gmail.com',
          style: TextStyle(
              color: const Color(0xffA3A1A6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
