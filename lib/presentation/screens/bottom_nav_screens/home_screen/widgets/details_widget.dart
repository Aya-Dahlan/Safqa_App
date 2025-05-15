import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';

import 'buttons_widget.dart';

class detailsWidget extends StatelessWidget {
  const detailsWidget({
    super.key,
    required this.nameProduct,
    required this.price,
    required this.namePerson,
    required this.location,
    required this.descProduct,
    required this.imagePerson,
    required this.dateAgo,
  });

  final String nameProduct;
  final String price;
  final String namePerson;
  final String location;
  final String descProduct;
  final String imagePerson;
  final String dateAgo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameProduct,
            style: TextStyle(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            children: [
              Text(
                price,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFFC200)),
              ),
              const Spacer(),
              Container(
                width: 60.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: const Color(0xffFFF0BF),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                child: Center(
                  child: Text(
                    'للإيجار',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xffCC9B00),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundImage: const AssetImage(
                  AppAssets.profile,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                namePerson,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              SvgPicture.asset(imagePerson),
              const Spacer(),
              Container(
                width: 60.w,
                height: 32.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Center(
                  child: Text(
                    'تابع',
                    style: TextStyle(
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.location),
              SizedBox(
                width: 4.w,
              ),
              Text(
                location,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xff535455),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            dateAgo,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            'الوصف',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
          SizedBox(
            height: 4.h,
          ),
          SizedBox(
            height: 102.h,
            child: Text(
              descProduct,
              style: TextStyle(
                fontSize: 12.sp,
                height: 150 / 100,
                color: const Color(0xffABB3C8),
              ),
            ),
          ),
          Row(
            children: [
              buttonsWidget(
                icoon: 'assets/icons/chat.svg',
                title: 'محادثة',
                isFill: true,
                onTap: () {},
              ),
              SizedBox(
                width: 13.w,
              ),
              buttonsWidget(
                icoon: 'assets/icons/call.svg',
                title: 'اتصال',
                isFill: false,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          CustomButton(onTap: () {}, title: 'اشتري الآن')
        ],
      ),
    );
  }
}
