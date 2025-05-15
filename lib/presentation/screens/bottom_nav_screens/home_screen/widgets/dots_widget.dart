import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class dots_widget extends StatelessWidget {
  const dots_widget({
    super.key,
    required this.images,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final List<String> images;
  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: images.asMap().entries.map((entry) {
          return Container(
            width: _currentIndex == entry.key ? 8.w : 6.w,
            height: _currentIndex == entry.key ? 8.w : 6.w,
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == entry.key
                  ? Colors.white
                  : Colors.white.withOpacity(0.4),
            ),
          );
        }).toList(),
      ),
    );
  }
}
