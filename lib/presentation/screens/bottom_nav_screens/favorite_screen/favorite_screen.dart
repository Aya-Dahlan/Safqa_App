import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/utils/styles.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/custom_product_vert_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/search_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375.w,
          height: 115.h,
          decoration: BoxDecoration(color: Color(0xffF6FAFD)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: arrowBackWidget(context),
                    ),
                    Spacer(),
                    Text(
                      'المفضلة',
                      style: TextStyles.appBarTitle,
                    ),
                    Spacer(),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        const CustomProductVertWidget(
          imagePath: '',
          title: 'سيارة كيا بيجاس بحالة الجديد...',
          owner: 'ناصر العتيبي',
          price: '30000',
          location: 'الرياض-حي ظهرة لبن',
          duration: '3 أيام',
        ),
        const CustomProductVertWidget(
          imagePath: '',
          title: 'سيارة كيا بيجاس بحالة الجديد...',
          owner: 'ناصر العتيبي',
          price: '30000',
          location: 'الرياض-حي ظهرة لبن',
          duration: '3 أيام',
        ),
        const CustomProductVertWidget(
          imagePath: '',
          title: 'سيارة كيا بيجاس بحالة الجديد...',
          owner: 'ناصر العتيبي',
          price: '30000',
          location: 'الرياض-حي ظهرة لبن',
          duration: '3 أيام',
        ),
      ],
    );
  }
}
