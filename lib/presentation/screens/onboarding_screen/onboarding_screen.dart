import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_router.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> onboardingData = [
    OnboardingData(
      title: "لا تحتاجه؟ شخص آخر يحتاجه!",
      description:
          "تحويل ممتلكاتك المستعملة التي لا تحتاجها إلى نقود فكرة رائعة لتحرير مساحة في منزلك والاستفادة من العائد.",
      imagePath: "assets/icons/onboarding1.svg",
    ),
    OnboardingData(
      title: "اكتشف خيارات لا حصر لها",
      description:
          "استكشف شبكتنا الواسعة من العروض المستعملة مما يتيح لك شراء الخيار وفقًا لاحتياجاتك وميزانيتك.",
      imagePath: "assets/icons/onboarding2.svg",
    ),
    OnboardingData(
      title: "صفقات مضمونة وفرص رابحة",
      description:
          "نقدم لك مجموعة واسعة من الصفقات الرابحة المدعومة بالأمان والثقة، التمكن من اغتنام أفضل الفرص دون أي قلق.",
      imagePath: "assets/icons/onboarding3.svg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6FAFD),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  title: onboardingData[index].title,
                  description: onboardingData[index].description,
                  imagePath: onboardingData[index].imagePath,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(onboardingData.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                width: 10.w,
                height: 10.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? kPrimaryColor : Colors.white,
                  border: _currentIndex == index
                      ? Border.all(color: kPrimaryColor, width: 1.w)
                      : Border.all(color: kPrimaryColor, width: 1.w),
                ),
              );
            }),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _pageController.jumpToPage(2);
                    });
                  },
                  child: Text(
                    "تخطي",
                    style: TextStyle(
                        color: Color(0xff0C0B19),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Container(
                  width: 118.w,
                  height: 68.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentIndex == onboardingData.length - 1) {
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kSignupScreen);
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF13294B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.0.w, vertical: 0.0.h),
                      child: Text(
                        "التالي",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.h,
          )
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String imagePath;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            //  height: 280.h,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: ksplashColor),
          ),
          SizedBox(height: 14.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.sp,
                color: ksplashColor,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
