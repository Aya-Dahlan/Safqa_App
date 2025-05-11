import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/utils/app_assets.dart';
import 'package:safqa_app/core/utils/app_icons.dart';

class CustomProductWidget extends StatefulWidget {
  final List<String> imagePaths;
  final String title;
  final String owner;
  final String price;
  final String location;
  final String duration;
  final bool isNew;

  const CustomProductWidget({
    Key? key,
    required this.imagePaths,
    required this.title,
    required this.owner,
    required this.price,
    required this.location,
    required this.duration,
    this.isNew = false,
  }) : super(key: key);

  @override
  _CustomProductWidgetState createState() => _CustomProductWidgetState();
}

class _CustomProductWidgetState extends State<CustomProductWidget> {
  CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;
  bool isPressed = false;

  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isPressed = true;
        });
      },
      onLongPressEnd: (_) {
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        width: 163.w,
        height: 298.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  carouselController: _carouselController,
                  items: widget.imagePaths.map((path) {
                    // return Container(
                    //   clipBehavior: Clip.antiAlias,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   height: 161.h,
                    //   width: 163.w,
                    //   child: Image.asset(
                    //     path,
                    //     fit: BoxFit.fill,
                    //   ),
                    // );
                    return CachedNetworkImage(imageUrl: path);
                  }).toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    height: 161.h,
                    padEnds: false,
                    autoPlay: false,
                    scrollDirection: Axis.horizontal,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 20.w,
                  right: 20.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.imagePaths.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _carouselController.animateToPage(
                          entry.key,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                  right: 8.w,
                  top: 8.h,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFav = !isFav;
                      });
                    },
                    child: Container(
                      width: 28.w,
                      height: 28.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          isFav ? AppAssets.heartFill : AppAssets.heartImage,
                          width: 18.w,
                          height: 18.h,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.isNew)
                  Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        width: 37.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            'جديد',
                            style: TextStyle(
                                fontSize: 8.sp,
                                color: Color(0xffFFC200),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ))
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff0C0B19),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              widget.owner,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xffABB3C8),
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.price,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xffFFC200),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.location,
              style:
              TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SvgPicture.asset(AppIcons.calender),
                SizedBox(width: 8.w),
                Text(
                  widget.duration,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
