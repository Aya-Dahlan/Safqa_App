import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/styles.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';

class ReviewMemberScreen extends StatelessWidget {
  const ReviewMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
        leading: Padding(
          padding: const EdgeInsets.all(14),
          child: arrowBackWidget(context),
        ),
        title: Text(
          'عضوية التاجر',
          style: TextStyles.appBarTitle,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.download),
            SizedBox(
              height: 45.h,
            ),
            SizedBox(
              width: 196.w,
              child: Text(
                'جاري معالجة طلبك وستصلك رسالة تأكيد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff383839),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
