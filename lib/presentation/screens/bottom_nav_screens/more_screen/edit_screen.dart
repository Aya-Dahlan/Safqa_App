import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/widgets/header_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_text_field.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
        leading: Padding(
          padding: EdgeInsets.all(14),
          child: arrowBackWidget(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
            ),
            HeaderWidget(),
            SizedBox(
              height: 42.h,
            ),
            CustomTextField(hintText: 'آلاء حمدي'),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(hintText: '01558356702'),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(hintText: 'alaabdallah@gmail.com'),
            SizedBox(
              height: 180.h,
            ),
            GestureDetector(
              onTap: () {
                showSuccessDialog(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'حذف الحساب',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xffD82E34),
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            CustomButton(onTap: () {}, title: 'حفظ التعديلات')
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
          height: 330.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 32.h,
                ),
                SvgPicture.asset(AppIcons.delete_pic),
                SizedBox(height: 16.h),
                Text(
                  "هل تريد بالفعل حذف حسابك؟",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff383839),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  "هذا الإجراء لا يمكن التراجع عنه وسيمسح جميع بياناتك بشكل دائم",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff8B93A7),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    CustomButton(
                      onTap: () {
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kMainScreen);
                      },
                      title: 'تأكيد',
                      height: 56,
                      color: Colors.white,
                      iswhite: true,
                      isBorder: true,
                      width: 130,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    CustomButton(
                      onTap: () {
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kLoginScreen);
                      },
                      title: 'إلغاء',
                      height: 56,
                      width: 130,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
