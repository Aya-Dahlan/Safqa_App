import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/core/utils/styles.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_text_field.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
        title: Text(
          'تسجيل التاجر',
          style: TextStyles.appBarTitle,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(14),
          child: arrowBackWidget(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الرجاء ملئ الحقول كاملة',
              style: TextStyle(
                  fontSize: 17.sp,
                  color: Color(0xff535455),
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 20.h,
              width: double.infinity,
            ),
            CustomTextField(hintText: 'الاسم'),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(hintText: 'رقم الجوال'),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(hintText: 'رقم الجوال'),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(hintText: 'العنوان'),
            SizedBox(
              height: 32.h,
            ),
            Container(
              width: 343.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kPrimaryColor, width: 0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.addPhoto),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'رفع صورة',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 193.h,
            ),
            CustomButton(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kReviewScreen);
                },
                title: 'تأكيد'),
          ],
        ),
      ),
    );
  }
}
