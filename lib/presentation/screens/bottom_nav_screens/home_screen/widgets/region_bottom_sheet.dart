import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/data/home_cubit/home_cubit.dart';
import 'package:safqa_app/data/home_cubit/home_state.dart';
import 'package:safqa_app/data/models/city_model.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';

class RegionFilterBottomSheet extends StatefulWidget {

  BuildContext context;

  RegionFilterBottomSheet(this.context, {Key? key}) : super(key: key);
  @override
  _RegionFilterBottomSheetState createState() =>
      _RegionFilterBottomSheetState(context);
}

class _RegionFilterBottomSheetState extends State<RegionFilterBottomSheet> {
  List<String> regions = [
    "الرياض",
    "مكة",
    "جدة",
    "الدمام",
    "المدينة المنورة",
    "الطائف",
    "الظهران"
  ];

  BuildContext ctx;

  _RegionFilterBottomSheetState(this.ctx);

  List<bool> selectedRegions = List.generate(7, (index) => false);

  void _clearSelection() {
    setState(() {
      selectedRegions = List.generate(regions.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (ctx, state) {
        switch (state.citiesStatus) {
          case CitiesStatus.initial:
          case CitiesStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case CitiesStatus.success:
            List<CityModel> items = state.cities;
            return Container(
              // height: 593.h,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // العنوان وزر حذف الكل
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _clearSelection,
                        child: const Text(
                          "حذف الكل",
                          style: TextStyle(
                              color: kPrimaryColor,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      Text(
                        "المنطقة",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: Color(0xff0C0B19)),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Color(0xffD0D1D2),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // حقل البحث
                  TextField(
                    decoration: InputDecoration(
                      hintText: "ابحث عن المنطقة",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // قائمة المناطق مع مربعات الاختيار
                  Expanded(
                    flex: 2,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          activeColor: kPrimaryColor,
                          // هنا يجب استخدام MaterialStateProperty
                          title: Text(items[index].nameAr!),
                          value: items[index].isSelected,
                          onChanged: (bool? value) {
                            ctx.read<HomeCubit>().selectRegion(index);
                            setState(() {});
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[300], // لون الفاصل
                        thickness: 1.w, // سمك الفاصل
                        height: 10.h, // المسافة بين العناصر
                      ),
                    ),
                  ),
                  SizedBox(height: 13.h),
                  // زر التطبيق
                  CustomButton(
                    onTap: () {
                      Navigator.pop(context, selectedRegions);
                    },
                    title: 'تطبيق',
                    height: 56.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            );

          case CitiesStatus.failure:
            return Center(
              child: Text(
                state.errorMessage!,
                style: TextStyle(fontSize: 16),
              ),
            );
        }
      },
    );
  }
}
