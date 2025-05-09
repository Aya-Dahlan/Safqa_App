import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/data/auth_cubit/auth_cubit.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/widgets/edit_button.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/widgets/header_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/widgets/row_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: Padding(
        padding: EdgeInsets.only(
          top: 40.h,
          left: 16.w,
          right: 16.w,
          bottom: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            const HeaderWidget(),
            SizedBox(
              height: 4.h,
            ),
            const EditButton(),
            SizedBox(
              height: 20.h,
            ),
            rowWidget(
              title: "منشوراتي",
              icon: AppIcons.myPosts,
              isFirst: true,
              onTap: () {},
            ),
            SizedBox(
              height: 1.h,
            ),
            rowWidget(
              title: "طلباتي",
              icon: AppIcons.myOrders,
              onTap: () {},
            ),
            SizedBox(
              height: 1.h,
            ),
            rowWidget(
              title: "عضوية التاجر",
              icon: AppIcons.credit,
              onTap: () {
                GoRouter.of(context).push(AppRouter.kMembershipScreen);
              },
              isLast: true,
            ),
            SizedBox(
              height: 16.h,
            ),
            rowWidget(
              title: 'الإشعارات',
              icon: AppIcons.notifications,
              isNoti: true,
              isFirst: true,
              isLast: true,
              onTap: () {},
            ),
            SizedBox(
              height: 16.h,
            ),
            rowWidget(
              onTap: () {},
              title: "مشاركة التطبيق",
              icon: AppIcons.share,
              isFirst: true,
            ),
            SizedBox(
              height: 1.h,
            ),
            rowWidget(
              onTap: () {},
              title: "الدعم الفني",
              icon: AppIcons.support,
            ),
            SizedBox(
              height: 1.h,
            ),
            rowWidget(
              onTap: () {},
              title: "شروط الاستخدام",
              icon: AppIcons.use,
            ),
            SizedBox(
              height: 1.h,
            ),
            rowWidget(
              onTap: () {},
              title: "سياسة الخصوصية",
              icon: AppIcons.privcy,
              isLast: true,
            ),

            rowWidget(
              onTap: ()async {
               await context.read<AuthCubit>().logout(context);
              },
              title: "تسجيل الخروج",
              icon: Icons.logout,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}
