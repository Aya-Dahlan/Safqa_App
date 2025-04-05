import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/styles.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/add_post_step_2_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/search_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_text_field.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375.w,
          height: 180.h,
          decoration: BoxDecoration(color: Color(0xffF6FAFD)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: arrowBackWidget(context),
                    ),
                    Spacer(),
                    Text(
                      'المحادثات',
                      style: TextStyles.appBarTitle,
                    ),
                    Spacer(),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SearchWidget(
                  title: 'ابحث عن المحادثة',
                  width: 343.w,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        ChatWidget(),
        SizedBox(
          height: 16.h,
        ),
        ChatWidget(),
        SizedBox(
          height: 16.h,
        ),
        ChatWidget(),
        SizedBox(
          height: 16.h,
        ),
        ChatWidget(),
        SizedBox(
          height: 16.h,
        ),
        const ChatWidget(),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 81.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xffEBECED), width: 1.w),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(AppAssets.profile),
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نايف القحطاني',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xff0C0B19),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'اهلاً محمد',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Color(0xff535455),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  '٠٩:٢٥ ص',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Color(0xff535455),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                      color: Color(0xff1D5FF5), shape: BoxShape.circle),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
