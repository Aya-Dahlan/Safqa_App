import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showLocationOptions(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // BottomSheet مع تأثير التمويه
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // زيادة التمويه
                child: Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.85), // تقليل الشفافية ليكون أوضح
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4), // حدود خفيفة
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.1), // ظل خفيف مطابق للصورة
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'إختر طريقة تحديد الموقع',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const Divider(height: 20, color: Colors.black26),
                      buildOptionItem(
                          context, 'القائمة', const Color(0xff007AFF), () {
                        Navigator.pop(context);
                      }),
                      const Divider(
                          height: 1, color: Colors.black26), // فاصل بين العناصر

                      buildOptionItem(
                          context, 'الخريطة', const Color(0xff007AFF), () {
                        Navigator.pop(context);
                      }),
                      const Divider(
                          height: 1, color: Colors.black26), // فاصل بين العناصر

                      buildOptionItem(context, 'إلغاء', Color(0xffFF3B30), () {
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                ),
              ),
            ),

            // السهم السفلي
            Positioned(
              bottom: 10.h,
              left: MediaQuery.of(context).size.width / 2 - 15.w,
              child: CustomPaint(
                size: Size(30.w, 10.h),
                painter: ArrowPainter(),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// تصميم السهم الصغير مثل الصورة
class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.85);
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height / 1)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 4, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget buildOptionItem(
    BuildContext context, String text, Color color, VoidCallback onTap) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ),
  );
}
