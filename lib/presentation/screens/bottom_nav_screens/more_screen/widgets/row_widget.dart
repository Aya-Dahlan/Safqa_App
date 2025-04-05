import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_icons.dart';

class rowWidget extends StatefulWidget {
  const rowWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.isFirst = false,
      this.isLast = false,
      this.isNoti = false});

  final String title;
  final String icon;
  final bool isFirst;
  final bool isLast;
  final bool isNoti;
  final VoidCallback onTap;

  @override
  State<rowWidget> createState() => _rowWidgetState();
}

class _rowWidgetState extends State<rowWidget> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 343.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: widget.isFirst
              ? const BorderRadius.only(
                  topRight: Radius.circular(8), topLeft: Radius.circular(8))
              : widget.isLast
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))
                  : null,
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            widget.icon,
            width: 20.w,
            height: 20.h,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: kHeadlineColor),
          ),
          trailing: widget.isNoti
              ? Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeTrackColor: Color(0xff2B3F6C),

                  activeColor: Colors.white, // لون التفعيل
                  inactiveThumbColor: Colors.white, // لون عند الإيقاف
                  inactiveTrackColor: Colors.grey, // لون المسار عند الإيقاف
                )
              : SvgPicture.asset(AppIcons.arrowForword),
        ),
      ),
    );
  }
}
