import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/utils/app_icons.dart';

class addPhotoWidget extends StatelessWidget {
  const addPhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90.w,
          height: 102.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffDBEAF9),
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.addPhoto),
              SizedBox(
                height: 19.h,
              ),
              Text(
                'إضافة صورة',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xff0C0B19),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Container(
          width: 90.w,
          height: 102.h,
          decoration: BoxDecoration(
              color: Color(0xffF6FAFD), borderRadius: BorderRadius.circular(8)),
        ),
        SizedBox(
          width: 12.w,
        ),
        Container(
          width: 90.w,
          height: 102.h,
          decoration: BoxDecoration(
              color: Color(0xffF6FAFD), borderRadius: BorderRadius.circular(8)),
        ),
      ],
    );
  }
}
