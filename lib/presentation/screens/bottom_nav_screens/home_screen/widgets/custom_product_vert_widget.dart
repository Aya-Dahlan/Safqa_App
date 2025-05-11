import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';

class CustomProductVertWidget extends StatefulWidget {
  const CustomProductVertWidget({
    super.key,
    this.isNew = false,
    required this.imagePath,
    required this.title,
    required this.owner,
    required this.price,
    required this.location,
    required this.duration,
  });

  final bool isNew;
  final String imagePath;
  final String title;
  final String owner;
  final String price;
  final String location;
  final String duration;

  @override
  State<CustomProductVertWidget> createState() =>
      _CustomProductVertWidgetState();
}

class _CustomProductVertWidgetState extends State<CustomProductVertWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12.h),
            width: 343.w,
            height: 125.h,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.4,
                  color: isPressed
                      ? Colors.red
                      : Colors.black.withOpacity(0.25), // ✅ تغيير لون الإطار
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withOpacity(25 / 100),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: Offset(0, 0),
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 8.5.w, right: 8.5.w, top: 9.5.h, bottom: 11.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.owner,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xff0C0B19),
                            ),
                          ),
                          if (widget.isNew)
                            SizedBox(
                              width: 90.w,
                            ),
                          if (widget.isNew)
                            Container(
                              width: 40.w,
                              height: 19.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.4.w,
                                    color: Color(0xffFFC200),
                                  ),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  'جديد',
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffFFC200)),
                                ),
                              ),
                            )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        widget.title.length>24?widget.title.substring(0,25) :widget.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff0C0B19),
                        ),
                      ),
                      SizedBox(
                        height: 7.8.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'للبيع',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Text(
                            widget.price,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffFFCE33)),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          SvgPicture.asset(AppIcons.calender),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            widget.duration,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.6.h,
                      ),
                      isPressed
                          ? Row(
                              children: [
                                Container(
                                  width: 48.w,
                                  height: 21.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: const Color(0xff1DB662),
                                      width: 0.4.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'تمييز',
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Color(0xff1DB662)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialogDelete(context);
                                  },
                                  child: Container(
                                    width: 48.w,
                                    height: 21.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: const Color(0xffD82E34),
                                        width: 0.4.w,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'حذف',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Color(0xffD82E34)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                SvgPicture.asset(AppIcons.location),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  widget.location,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: 114.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child:
                    Image.network(
                      widget.imagePath,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isPressed)
            Positioned(
              bottom: 20.h,
              left: 5.w,
              child: Container(
                width: 18.w,
                height: 18.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: const Color(0xffD82E34),
                ),
                child: Center(
                    child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 18.sp,
                )),
              ),
            ),
        ],
      ),
    );
  }
}

void showDialogDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: SizedBox(
          width: 342.w,
          height: 265.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                SvgPicture.asset(AppIcons.delete),
                SizedBox(height: 16.h),
                Text(
                  "هل تريد بالفعل حذف هذا المنشور؟",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff383839),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  children: [
                    CustomButton(
                      onTap: () {
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kSignupScreen);
                      },
                      title: 'تأكيد',
                      height: 56,
                      width: 130,
                      color: Colors.white,
                      iswhite: true,
                      isBorder: true,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    CustomButton(
                      onTap: () {
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kSignupScreen);
                      },
                      title: 'إلغاء',
                      height: 56,
                      width: 130,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
