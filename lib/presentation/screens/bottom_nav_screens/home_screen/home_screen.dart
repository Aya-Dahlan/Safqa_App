import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/data/models/category_model.dart';
import 'package:safqa_app/data/home_cubit/home_cubit.dart';
import 'package:safqa_app/data/home_cubit/home_state.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/map_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/custom_product_vert_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/custom_product_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/display_method_widget.dart.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/notfications_button.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/region_bottom_sheet.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/search_widget.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/types_widget.dart';

import '../../../../data/models/city_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = -1; // لتحديد التبويب النشط
  bool isGridView = false; // متغير لتحديد طريقة العرض

  final List<String> tabs = ["المنطقة", "الأحدث", "الأقرب"];
  final List<Widget> icons = [
    SvgPicture.asset(AppIcons.arrowDown),
    const SizedBox.shrink(), // بدون أيقونة للأحدث
    SvgPicture.asset(AppIcons.location),
  ];

  // List<Map<String, String>> items = [
  //   {'name': 'سيارات', 'image': AppAssets.car},
  //   {'name': 'عقارات', 'image': AppAssets.buildings},
  //   {'name': 'أثاث', 'image': AppAssets.furn},
  //   {'name': 'إلكترونيات', 'image': AppAssets.elect},
  //   {'name': 'معدات', 'image': AppAssets.equp},
  //   {'name': 'أجهزة المنزلية', 'image': AppAssets.homeAppl},
  //   {'name': 'مٌستلزمات', 'image': AppAssets.orange},
  //   {'name': 'أٌخرى', 'image': AppAssets.other},
  // ];
  List<String> imagePaths = [AppAssets.ipadPro, AppAssets.homeCar];
  void _showRegionBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.74,
      context: context,
      //  isScrollControlled: true, // لجعل الـ BottomSheet يأخذ الحجم المناسب
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (ctx) => RegionFilterBottomSheet(ctx),
    ).then((_) {
     // List<CityModel> selectedRegions=  context.read<HomeCubit>().state.cities.where((element) {
     //    return element.isSelected== true;
     //  },).toList();

      print(
        context.read<HomeCubit>().state.selectedRegions
            .map((e) => e.nameAr)
            .toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 68.h, left: 16.w, right: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SearchWidget(),
                SizedBox(width: 16.w),
                const NotificationsButton(),
              ],
            ),
            SizedBox(height: 20.h),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state.categoryStatus) {
                  case CategoryStatus.initial:
                  case CategoryStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case CategoryStatus.success:
                    List<CategoryModel> items = state.categories.where(
                      (element) {
                        return element.parentId == 0;
                      },
                    ).toList(
                    );
                    return SizedBox(
                      height: 190.h,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: items.length,
                        clipBehavior: Clip.none,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 15.h,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          return TypesWidget(
                            name: items[index].name,
                            onTap: () async{
                               // context.read<HomeCubit>().selectCategory(index);
                               await GoRouter.of(context).push(
                                AppRouter.kCategoryDetailsScreen,
                                 extra: items[index],
                              );

                            },
                            image: items[index].image?? AppAssets.car,
                          );
                        },
                      ),
                    );

                  case CategoryStatus.failure:
                    return  Center(
                      child: Text(
                        state.errorMessage!,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                }
              },
            ),

            SizedBox(height: 30.h),

            // شريط التبويبات
            Row(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(tabs.length, (index) {
                    bool isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          if (index == 0) {
                            _showRegionBottomSheet(
                                context); // فتح الـ Bottom Sheet عند الضغط على "المنطقة"
                          }
                          if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(),
                              ),
                            );
                          }
                        });
                      },
                      child: Container(
                        width: index == 1
                            ? 61.w
                            : index == 2
                                ? 73.w
                                : 101.w, // الأحدث أصغر حجمًا
                        height: 32.h,
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          color: isSelected ? kPrimaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: kPrimaryColor, width: 0.5.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (index !=
                                1) // عرض الأيقونة فقط إذا لم يكن التبويب هو "الأحدث"
                              SvgPicture.asset(
                                index == 0
                                    ? AppIcons.arrowDown
                                    : AppIcons.location,
                                color:
                                    isSelected ? Colors.white : kPrimaryColor,
                              ),
                            if (index != 1)
                              SizedBox(width: 4.w), // تباعد بين الأيقونة والنص

                            Text(
                              tabs[index],
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color:
                                    isSelected ? Colors.white : kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        isGridView = !isGridView; // تغيير طريقة العرض عند الضغط
                      });
                    },
                    child: DisplayMethodWidget(
                      isGridView: isGridView,
                      onTap: () {
                        setState(() {
                          isGridView = !isGridView; // تغيير الحالة عند الضغط
                        });
                      },
                    ))
              ],
            ),

            SizedBox(height: 16.7.h),
            // عرض المنتجات حسب الحالة
            isGridView
                ? GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // عرض منتجين في كل صف
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,

                      childAspectRatio: 0.1,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const CustomProductWidget(
                        imagePaths: [AppAssets.ipadPro, AppAssets.car],
                        title: 'آيباد برو',
                        owner: 'ناصر العتيبي',
                        price: '3000 ريال ',
                        location: 'الرياض-حي ظهرة لبن',
                        duration: '3 أيام',
                        isNew: true,
                      );
                    },
                  )
                : Column(
                    children: List.generate(4, (index) {
                      return const CustomProductVertWidget(
                        imagePath: AppAssets.ipadPro,
                        title: 'آيباد برو',
                        owner: 'ناصر العتيبي',
                        price: '3000 ريال ',
                        location: 'الرياض-حي ظهرة لبن',
                        duration: '3 أيام',
                      );
                    }),
                  ),
          ],
        ),
      ),
    );
  }
}
