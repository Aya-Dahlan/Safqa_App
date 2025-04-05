import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/presentation/screens/login_screens/widgets/description_widget.dart';
import 'package:safqa_app/presentation/screens/login_screens/widgets/title_text_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            arrowBackWidget(context),
            SizedBox(height: 32.h),
            const titleTextWidget(title: 'إعادة كلمة المرور'),
            SizedBox(height: 12.h),
            const descriptionWidget(
              text:
                  'قم بإدخال كلمة مرور جديدة لتتمكن من تسجيل الدخول مرة أخري.',
            ),
            SizedBox(height: 24.h),
            const CustomTextField(
              hintText: ' كلمة المرور الجديدة',
            ),
            SizedBox(
              height: 16.h,
            ),
            const CustomTextField(
              hintText: 'تأكيد كلمة المرور',
              isPassword: true,
            ),
            SizedBox(
              height: 125.h,
            ),
            CustomButton(
                onTap: () {
                  showSuccessDialog(context);
                },
                title: 'تأكيد'),
          ],
        ),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: SizedBox(
          width: 343.w,
          height: 360.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 32.h,
                ),
                Image.asset(AppAssets.doneImage),
                SizedBox(height: 48.h),
                Text(
                  "تم تعيين كلمة المرور بنجاح",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff383839),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                CustomButton(
                  onTap: () {
                    GoRouter.of(context)
                        .pushReplacement(AppRouter.kLoginScreen);
                  },
                  title: 'تسجيل الدخول',
                  height: 48,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomButton(
                  onTap: () {
                    GoRouter.of(context).pushReplacement(AppRouter.kMainScreen);
                  },
                  title: 'الصفحة الرئيسية',
                  height: 48,
                  color: Colors.white,
                  iswhite: true,
                  isBorder: true,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
