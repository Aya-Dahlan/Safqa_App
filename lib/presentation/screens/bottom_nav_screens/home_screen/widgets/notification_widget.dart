import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: SizedBox(
        width: 343.w,
        height: 108.h,
        //color: Colors.grey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 271.w,
                      child: Text(
                        'لم تكمل إضافة إعلانك بعد. اضغط هنا لمتابعة العملية وإضافة التفاصيل المتبقية',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff383839),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      'منذ ٣ ساعات',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffABB3C8)),
                    )
                  ],
                ),
                Spacer(),
                Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff1D5FF5),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              width: 343.w,
              height: 1.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color: const Color(0xffDBEAF9),
              ),
            )
          ],
        ),
      ),
    );
  }
}
