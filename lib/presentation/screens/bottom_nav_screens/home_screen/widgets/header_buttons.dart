import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';

import 'icon_widget.dart';

class header_buttons extends StatelessWidget {
  const header_buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 61.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            IconWidget(
              onPressed: () {
                print('object');
               Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: kPrimaryColor,
                size: 20.sp,
              ),
              isRect: true,
            ),
            const Spacer(),
            IconWidget(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: kPrimaryColor,
              ),
              isRect: false,
            ),
            SizedBox(
              width: 8.w,
            ),
            IconWidget(
              onPressed: () {},
              icon: const Icon(
                Icons.share_rounded,
                color: kPrimaryColor,
              ),
              isRect: false,
            ),
          ],
        ),
      ),
    );
  }
}
