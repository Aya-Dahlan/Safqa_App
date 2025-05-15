import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safqa_app/core/utils/app_icons.dart';

import '../../../../../data/models/category_model.dart';

class CustomDropdown extends StatefulWidget {
  final double width; // عرض متغير
  final List<CategoryModel>? items;
  final Function(CategoryModel)? onChanged;

  const CustomDropdown({
    super.key,
    required this.width,
    required this.items,
    required this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  CategoryModel? selectedCategory; // القيمة المختارة

  @override
  void initState() {
    super.initState();
    // selectedCategory = widget.items.isNotEmpty
    //     ? widget.items.first
    //     : null; // ضبط القيمة الأولية
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 44.h,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color: Color(0xffEBECED),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<CategoryModel>(
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(8),
            isExpanded: true,
            icon: SvgPicture.asset(
              AppIcons.arrowDown,
              width: 10.w,
              height: 10.h,
            ),
            style: TextStyle(
              color: Color(0xffD0D1D2),
              fontSize: 14.sp,
            ),
            value: selectedCategory,
            onChanged: (CategoryModel? newValue) {
              // setState(() {
              //   selectedCategory = newValue!;
              // });
              // widget.onChanged(newValue!);
            },
            items:widget.items==null? []: widget.items!.map<DropdownMenuItem<CategoryModel>>((CategoryModel value) {
              return DropdownMenuItem<CategoryModel>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
