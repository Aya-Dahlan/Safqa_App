import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypesWidget extends StatelessWidget {
  const TypesWidget({
    super.key,
    required this.image,
    required this.name,
    required this.onTap,
  });

  final String image;
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Column(
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
      ),
    );
  }
}
