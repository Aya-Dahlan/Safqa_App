import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/core/utils/styles.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/widgets/add_photo_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/widgets/bottom_sheet_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/widgets/custom_drop_button.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/widgets/slider_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_text_field.dart';

class AddPostStep2Screen extends StatelessWidget {
  const AddPostStep2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
        title: Text(
          'إضافة منشور',
          style: TextStyles.appBarTitle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropdown(
                  width: 163.w, // التحكم في العرض
                  items: [
                    'الموديل',
                    'القسم الأول',
                    'القسم الثاني',
                    'القسم الثالث'
                  ],
                  onChanged: (value) {
                    print('القسم المختار: $value');
                  },
                ),
                CustomDropdown(
                  width: 163.w, // التحكم في العرض
                  items: [
                    'الجير',
                    'القسم الأول',
                    'القسم الثاني',
                    'القسم الثالث'
                  ],
                  onChanged: (value) {
                    print('القسم المختار: $value');
                  },
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            const CustomTextField(hintText: 'عدد الكيلو مترات'),
            SizedBox(
              height: 16.h,
            ),
            const CustomTextField(
              hintText: 'السعر',
              issuff: true,
              suff: Text(
                'ريال',
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomDropdown(
              width: 343.w,
              items: const ['إختر المنطقة', '1', '2', '3'],
              onChanged: (value) {
                print('القسم المختار: $value');
              },
            ),
            SizedBox(
              height: 193.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SliderWidget(
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: 8.w,
                ),
                const SliderWidget(
                  color: kPrimaryColor,
                )
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomButton(
              onTap: () {
                showLocationOptions(context);
              },
              title: 'تأكيد',
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomButton(
              onTap: () {
                showDialogSignin(context);
              },
              title: 'تأكيد مع تمييز',
              iswhite: true,
              color: const Color(0xffDBEAF9),
            ),
          ],
        ),
      ),
    );
  }
}

void showDialogSignin(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: SizedBox(
          width: 343.w,
          height: 268.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 32.h,
                ),
                SvgPicture.asset(AppIcons.login),
                SizedBox(height: 16.h),
                Text(
                  "ليس لديك حساب في صفقة ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff383839),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  "لإضافة منشورك يرجي انشاء حساب ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xffABB3C8),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32.h,
                ),
                CustomButton(
                  onTap: () {
                    GoRouter.of(context)
                        .pushReplacement(AppRouter.kSignupScreen);
                  },
                  title: 'إنشاء حساب',
                  height: 48.h,
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
