import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/presentation/screens/login_screens/widgets/description_widget.dart';
import 'package:safqa_app/presentation/screens/login_screens/widgets/title_text_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _seconds = 30; // مدة العد التنازلي بالثواني
  late Timer _timer;
  bool _isResendEnabled = false;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _isResendEnabled = false;
      _seconds = 30; // إعادة ضبط العداد
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
          _timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
            SizedBox(height: 32.h),
            const titleTextWidget(title: 'أدخل رمز التحقق'),
            SizedBox(height: 12.h),
            const descriptionWidget(
              text:
                  'تم إرسال رمز التحقق الي جوالك يرجي التحقق من تطبيق الرسائل لديك',
            ),
            SizedBox(height: 45.h),
            OtpTextField(
              fieldWidth: 55.8.w, // عرض الحقول
              borderRadius: BorderRadius.circular(8), // حواف دائرية
              margin: EdgeInsets.symmetric(
                horizontal: 11.h,
              ), // مسافات بين الحقول
              numberOfFields: 4, // عدد الحقول
              borderColor: const Color(0xffD0D1D2), // لون الحدود
              borderWidth: 0.5.w,
              focusedBorderColor: kPrimaryColor, // لون عند التحديد
              showFieldAsBox: true, // إظهار الحقول كمربعات
              fillColor: const Color(0xffF5F5F5),
              keyboardType: TextInputType.number,
              filled: true,
              textStyle: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff10375C),
              ),
              onCodeChanged: (String code) {
                // يمكنك تنفيذ أي منطق هنا عند تغيير الكود
              },
              onSubmit: (String verificationCode) {
                // قم بتنفيذ ما تريد عند إدخال الكود بالكامل
              },
            ),
            SizedBox(
              height: 45.h,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "لم تتلقى الرمز ",
                  style: TextStyle(
                      fontFamily: 'Montserrat-Arabic',
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300),
                  children: [
                    TextSpan(
                      text: _isResendEnabled
                          ? ""
                          : "00:${_seconds.toString().padLeft(2, '0')}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xffD82E34),
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: " ؟    ",
                      style: TextStyle(
                          fontFamily: 'Montserrat-Arabic',
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: _isResendEnabled ? _startTimer : null,
                        child: Text(
                          "إعادة إرسال",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Montserrat-Arabic',
                            color:
                                _isResendEnabled ? kPrimaryColor : Colors.grey,
                            fontWeight: FontWeight.w400,
                            decoration: _isResendEnabled
                                ? TextDecoration.underline
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 75.h,
            ),
            CustomButton(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kResetPasswordScreen);
                },
                title: 'تأكيد'),
          ],
        ),
      ),
    );
  }
}
