import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
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

import '../../../../../data/models/post_model.dart';
import '../../../../widgets/arrow_back_widget.dart';


class CategoryDetailsScreen extends StatefulWidget {
   CategoryDetailsScreen({super.key,required this.categoryModel});
  CategoryModel categoryModel;
  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState(categoryModel);
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {

  CategoryModel categoryModel;

  _CategoryDetailsScreenState(this.categoryModel);
  int selectedIndex = -1; // لتحديد التبويب النشط
  bool isGridView = false; // متغير لتحديد طريقة العرض

  final List<String> tabs = ["المنطقة", "الأحدث", "الأقرب"];
  final List<Widget> icons = [
    SvgPicture.asset(AppIcons.arrowDown),
    const SizedBox.shrink(), // بدون أيقونة للأحدث
    SvgPicture.asset(AppIcons.location),
  ];

  initState() {
    super.initState();
  }

  List<Map<String, String>> items = [
    {'name': 'سيارات', 'image': AppAssets.car},
    {'name': 'عقارات', 'image': AppAssets.buildings},
    {'name': 'أثاث', 'image': AppAssets.furn},
    {'name': 'إلكترونيات', 'image': AppAssets.elect},
    {'name': 'معدات', 'image': AppAssets.equp},
    {'name': 'أجهزة المنزلية', 'image': AppAssets.homeAppl},
    {'name': 'مٌستلزمات', 'image': AppAssets.orange},
    {'name': 'أٌخرى', 'image': AppAssets.other},
  ];
  List<String> imagePaths = [AppAssets.ipadPro, AppAssets.homeCar];
  void _showRegionBottomSheet(BuildContext ctx,) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.74,
      context: context,
      //  isScrollControlled: true, // لجعل الـ BottomSheet يأخذ الحجم المناسب
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (ctx) => RegionFilterBottomSheet(ctx,),
    ).then((_) async{
      await context.read<HomeCubit>().getPostsRegions(categoryId:categoryModel.id);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit,HomeState>(
        builder: (context,state){
          switch(state.categoryDetailsStatus){
            case CategoryDetailsStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case CategoryDetailsStatus.initial:
            case CategoryDetailsStatus.success:
              List<CategoryModel> items= state.categories.where(
                      (element) {
                        return element.parentId == categoryModel.id;
                      }
              ).toList();
              return Padding(
                padding: EdgeInsets.only(top: 68.h, left: 16.w, right: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: arrowBackWidget(context),
                          ),
                          const SearchWidget(),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        categoryModel.name,
                        style: TextStyle(
                            fontSize: 14.sp,
                            //  color: kTextColorLight,
                            fontWeight: FontWeight.w700),
                      ),

                      SizedBox(height: 10.h),

                      _buildCategoryTabs(items:items,state: state),
                      if(state.subCategories.isNotEmpty) ...[
                        SizedBox(height: 14.h),
                        SizedBox(
                          height: 18.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.subCategories.length,
                            itemBuilder: (context, index) {

                              return GestureDetector(
                                onTap: (){
                                  context.read<HomeCubit>().selectSubCategory(index,state.subCategories);
                                  // print(state.categories[index].name);
                                },
                                child: Text( state.subCategories[index].name,style: TextStyle(
                                    color:state.subCategories[index].isSelected? Color(0xff10375C) : Colors.black
                                ),),
                              );
                            },
                            separatorBuilder:  (context, index) => SizedBox(
                              width: 10.w,
                            ),
                          ),
                        ),
                      ],



                      SizedBox(height: 30.h),

                      // شريط التبويبات
                      Row(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(tabs.length, (index) {
                              bool isSelected = selectedIndex == index;
                              return GestureDetector(
                                onTap: () async{
                                  setState(() {
                                    selectedIndex = index;
                                    if (index == 0) {
                                      _showRegionBottomSheet(
                                          context);
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
                                  if(index == 1){
                                    await context.read<HomeCubit>().getNewestPosts(
                                      categoryId: categoryModel.id
                                    );
                                  }
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
                      // isGridView
                      //     ? GridView.builder(
                      //   padding: EdgeInsets.zero,
                      //   shrinkWrap: true,
                      //   // physics: const NeverScrollableScrollPhysics(),
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2, // عرض منتجين في كل صف
                      //     crossAxisSpacing: 10.w,
                      //     mainAxisSpacing: 10.h,
                      //
                      //     childAspectRatio: 0.1,
                      //   ),
                      //   itemCount: 4,
                      //   itemBuilder: (context, index) {
                      //     return const CustomProductWidget(
                      //       imagePaths: [AppAssets.ipadPro, AppAssets.car],
                      //       title: 'آيباد برو',
                      //       owner: 'ناصر العتيبي',
                      //       price: '3000 ريال ',
                      //       location: 'الرياض-حي ظهرة لبن',
                      //       duration: '3 أيام',
                      //       isNew: true,
                      //     );
                      //   },
                      // )
                      //     : Column(
                      //   children: List.generate(4, (index) {
                      //     return const CustomProductVertWidget(
                      //       imagePath: AppAssets.ipadPro,
                      //       title: 'آيباد برو',
                      //       owner: 'ناصر العتيبي',
                      //       price: '3000 ريال ',
                      //       location: 'الرياض-حي ظهرة لبن',
                      //       duration: '3 أيام',
                      //     );
                      //   }),
                      // ),

                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          switch (state.postsStatus) {
                            case PostsStatus.initial:
                            case PostsStatus.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case PostsStatus.success:
                              return state.filterdPosts!.isNotEmpty? isGridView
                                  ? GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // عرض منتجين في كل صف
                                  crossAxisSpacing: 10.w,
                                  mainAxisSpacing: 10.h,

                                  childAspectRatio: 0.1,
                                ),
                                itemCount: state.filterdPosts!.length,
                                itemBuilder: (context, index) {
                                  PostModel post= state.filterdPosts![index];

                                  return CustomProductWidget(
                                    imagePaths: post.galleryToStringList(),
                                    title: post.title!,
                                    owner: post.user!.name!,
                                    price: '${post.price!} ريال ',
                                    location: '${post.region!.name} - ${post.district!.name}',
                                    duration: post.parseDate(DateTime.parse(post.updatedAt!)),
                                    isNew: DateTime.now().difference(DateTime.parse(post.createdAt!)).inDays <7 ?true:false,
                                  );
                                },
                              )
                                  : Column(
                                children: List.generate(state.filterdPosts!.length, (index) {
                                  PostModel post= state.filterdPosts![index];
                                  print(post.region!.name);
                                  return  CustomProductVertWidget(
                                    imagePath: post.gallery![0].original!,
                                    title:post.title!,
                                    owner:post.user!.name!,
                                    price: '${post.price!} ريال ',
                                    location: '${post.region!.name}-${post.district!.name}',
                                    duration: post.parseDate(DateTime.parse(post.updatedAt!)),
                                  );
                                }),
                              ): Center(child: Text('لا يوجد منتجات'),);

                            case PostsStatus.failure:
                              return Text(state.errorMessage!);
                          }
                        },
                      )
                    ],
                  ),
                ),
              );

            case CategoryDetailsStatus.failure:
              return Center(
                child: Text(
                  state.errorMessage!,
                  style: TextStyle(fontSize: 16),
                ),
              );
          }
        },
      ),
    );
  }

  Widget _buildCategoryTabs({required List<CategoryModel> items,required HomeState state}) {
    return SizedBox(
      height: 34.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: GestureDetector(
              onTap: () {
        context.read<HomeCubit>().selectCategory(index,items[index].id,items);
              },
              //#2E5579
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color:items[index].isSelected ? kPrimaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: Color(0xff2E5579),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    items[index].name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: items[index].isSelected ? Colors.white : kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
