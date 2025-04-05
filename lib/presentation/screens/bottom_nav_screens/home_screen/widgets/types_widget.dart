import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypesWidget extends StatelessWidget {
  const TypesWidget({
    super.key,
    required this.image,
    required this.name,
  });

  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffF6FAFD),
          ),
          child: Center(
            child: Image.asset(
              image,
              width: 60.w,
              height: 40.h,
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        FittedBox(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
            ),
          ),
        )
      ],
    );
  }
}
