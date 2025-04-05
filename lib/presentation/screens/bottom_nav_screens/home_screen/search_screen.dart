import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isBefore = true;
  bool isTab = false;
  bool isEmpty = false;
  bool isChanging = false;

  // قائمة تجريبية لعمليات البحث السابقة
  List<String> previousSearches = [
    'منشأة تجريبية 1',
    'مالك تجريبي 2',
    'رخصة تجريبية 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صندوق البحث
              Row(
                children: [
                  Container(
                    width: isTab ? 311.w : 343.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F1F1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onTap: () {
                                setState(() {
                                  isTab =
                                      true; // عند الضغط على حقل النص، يتم تحديث isTab
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  isChanging = true;
                                  isBefore = false;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'ابحث عن منشأة, مالك, رخصة...',
                                hintStyle: TextStyle(
                                  color: const Color(0xffBDBDBD),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                          // إذا كانت قيمة isTab صحيحة، يتم عرض زر "إلغاء"

                          // GestureDetector(
                          //   onTap: () {},
                          //   child: SvgPicture.asset(
                          //     AssetsData.search,
                          //     width: 15.w,
                          //     height: 15.h,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  if (isTab)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTab =
                              false; // إلغاء البحث، يتم إعادة isTab إلى false
                          isBefore = true; // تعيد عرض "آخر عمليات البحث"
                          isChanging = false;
                        });
                      },
                      child: Text(
                        'إلغاء',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: isEmpty ? 176.h : 16.h,
              ),

              if (isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(AssetsData.noSearch),
                      Text(
                        'لم يتم العثور على نتائج ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          //   color: kTextColorLight
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          ' حاول مرة أخرى',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              color: kPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              if (isChanging)
                Text(
                  'نتائج البحث عن [موضوع البحث]',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),

              if (isBefore)
                Text(
                  'آخر عمليات البحث',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),

              SizedBox(
                height: 16.h,
              ),

              if (isChanging)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المالكون',
                      style: TextStyle(
                          fontSize: 11.sp,
                          //  color: kTextColorLight,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 26.w,
                          height: 26.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset('assets/images/profilePh.jpeg'),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          'اسم المالك',
                          style: TextStyle(
                              fontSize: 10.sp,
                              //  color: kTextColorLight,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      width: 343.w,
                      height: 0.5.h,
                      color: Color(0xffC4C4C4),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      'المنشآت',
                      style: TextStyle(
                          fontSize: 11.sp,
                          //   color: kTextColorLight,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 26.w,
                          height: 26.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)),
                          child: Image.asset(
                            'assets/images/facility.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          'اسم المنشأة',
                          style: TextStyle(
                              fontSize: 10.sp,
                              //color: kTextColorLight,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),

              if (isBefore)
                Expanded(
                  child: ListView.builder(
                    itemCount: previousSearches.length,
                    itemBuilder: (context, index) {
                      return searchBeforeWidget(
                        title: previousSearches[index],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class searchBeforeWidget extends StatelessWidget {
  final String title;

  const searchBeforeWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: const Color(0xff717171),
              ),
            ),
            const Spacer(),
            // SvgPicture.asset(
            //   // AssetsData.search,
            //   height: 15.h,
            //   color: const Color(0xff717171),
            // ),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        Container(
          width: 343.w,
          height: 0.5.h,
          color: const Color(0xffC4C4C4),
        ),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}
