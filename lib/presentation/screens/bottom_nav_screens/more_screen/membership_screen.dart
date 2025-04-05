import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/core/utils/styles.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/add_post_step_2_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/widgets/member_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  String selectedValue = '6 أشهر'; // القيمة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: arrowBackWidget(context),
        ),
        title: Text(
          'عضوية التاجر',
          style: TextStyles.appBarTitle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Container(
            width: 276.w,
            height: 372.h,
            decoration: BoxDecoration(
              color: const Color(0xffF6FAFD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'زيادة المشاهدات',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    width: 112.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: PopupMenuButton<String>(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // تدوير الحواف للقائمة
                      ),
                      onSelected: (value) {
                        setState(() {
                          selectedValue = value; // تحديث النص عند الاختيار
                        });
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                            value: '1 شهر', child: Text('1 شهر')),
                        const PopupMenuItem(
                            value: '3 أشهر', child: Text('3 أشهر')),
                        const PopupMenuItem(
                            value: '6 أشهر', child: Text('6 أشهر')),
                        const PopupMenuItem(value: 'سنة', child: Text('سنة')),
                      ],
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 7.h),
                        child: Row(
                          children: [
                            Text(
                              selectedValue,
                              style: TextStyle(
                                  fontSize: 12.sp, color: kPrimaryColor),
                            ),
                            const Spacer(),
                            SvgPicture.asset(AppIcons.arrowDown),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const memberWiget(
                    title: 'متجر خاص بتصميم مميز',
                    icon: AppIcons.cart,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const memberWiget(
                    title: 'إضافة إسم وصورة المتجر',
                    icon: AppIcons.photo,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const memberWiget(
                    title: 'إضافة علامة التوثيق لحسابك ',
                    icon: AppIcons.doneCir,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const memberWiget(
                    title: 'عدد النشر اليومي لا محدود',
                    icon: AppIcons.infinity,
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Text(
                    '299.00 ريال',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0xffFFC200),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kAddMemberScreen);
                    },
                    title: 'إشترك الآن',
                    height: 42,
                    width: 220,
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          CustomButton(onTap: () {}, title: 'مٌتابعة'),
          SizedBox(
            height: 40.h,
          )
        ],
      ),
    );
  }
}
