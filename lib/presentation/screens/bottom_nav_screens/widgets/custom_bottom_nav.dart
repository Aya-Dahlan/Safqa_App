import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar(
      {Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  Color _buttonColor = Color(0xff2E5579);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 4.h,
          ),
          child: Container(
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff85858540).withOpacity(25 / 100),
                  offset: const Offset(0, 4),
                  blurRadius: 25,
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildNavBarItem(
                    widget.selectedIndex == 0
                        ? AppAssets.homeFill
                        : AppAssets.homeImage,
                    'الرئيسية',
                    0,
                  ),
                  buildNavBarItem(
                    widget.selectedIndex == 1
                        ? AppAssets.heartFill
                        : AppAssets.heartImage,
                    'المُفضلة',
                    1,
                  ),
                  SizedBox(width: 30.w),
                  buildNavBarItem(
                    widget.selectedIndex == 2
                        ? AppAssets.chatsFill
                        : AppAssets.chats,
                    'المحادثات',
                    2,
                  ),
                  buildNavBarItem(
                    widget.selectedIndex == 3
                        ? AppAssets.moreFill
                        : AppAssets.moreImage,
                    'المزيد',
                    3,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 138.w,
          right: 138.w,
          bottom: 67.h,
          child: GestureDetector(
            onTapDown: (_) {
              setState(() {
                _buttonColor = const Color(0xff004590);
              });
            },
            onTapUp: (_) {
              setState(() {
                _buttonColor = kPrimaryColor;
              });
            },
            onTapCancel: () {
              setState(() {
                _buttonColor = kPrimaryColor;
              });
            },
            onTap: () {
              GoRouter.of(context).push(AppRouter.kAddPostStep1Screen);
            },
            child: Container(
              width: 64.49.w,
              height: 64.49.h,
              decoration: BoxDecoration(
                color: _buttonColor, // استخدام المتغير الذي يخزن اللون الحالي
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffB0B0B0).withOpacity(33 / 100),
                    blurRadius: 9,
                    offset: const Offset(0, 3),
                    spreadRadius: 6,
                  )
                ],
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 40.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNavBarItem(String icon, String label, int index) {
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            icon,
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              color: widget.selectedIndex == index
                  ? Color(0xff2E5579)
                  : Color(0XffABB3C8),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
