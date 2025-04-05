import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/presentation/screens/login_screens/widgets/description_widget.dart';
import 'package:safqa_app/presentation/screens/login_screens/widgets/title_text_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
              width: double.infinity,
            ),
            arrowBackWidget(context),
            SizedBox(
              height: 32.h,
            ),
            const titleTextWidget(title: 'إستعادة كلمة المرور'),
            SizedBox(
              height: 12.h,
            ),
            const descriptionWidget(
              text:
                  'قم بإدخال رقم الجوال   رمز التحقق لتتمكن من تسجيل الدخول مرة أخري.',
            ),
            SizedBox(
              height: 29.h,
            ),
            const CustomTextField(hintText: 'رقم الجوال'),
            SizedBox(
              height: 123.h,
            ),
            CustomButton(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kOTPScreen);
                },
                title: 'إرسال الرقم')
          ],
        ),
      ),
    );
  }
}
