import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/core/utils/styles.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/widgets/add_photo_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/widgets/custom_drop_button.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/widgets/slider_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/notifications_screen.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_text_field.dart';

class AddPostStep1Screen extends StatefulWidget {
  const AddPostStep1Screen({super.key});

  @override
  State<AddPostStep1Screen> createState() => _AddPostStep1ScreenState();
}

class _AddPostStep1ScreenState extends State<AddPostStep1Screen> {
  String selectedCategory = 'إختر القسم';
  String selectedCategory2 = 'إختر الفئة';

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
            const addPhotoWidget(),
            SizedBox(
              height: 16.h,
            ),
            const CustomTextField(hintText: ' أدخل عنوان للمنتج'),
            SizedBox(
              height: 16.h,
            ),
            const CustomTextField(
              hintText: ' الوصف',
              maxLines: 5,
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropdown(
                  width: 163.w, // التحكم في العرض
                  items: [
                    'إختر القسم',
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
                    'إختر الفئة',
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
              height: 131.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SliderWidget(
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: 8.w,
                ),
                SliderWidget(
                  color: Color(0xffF6FAFD),
                )
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomButton(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kAddPostStep2Screen);
              },
              title: 'مٌتابعة',
            ),
          ],
        ),
      ),
    );
  }
}
