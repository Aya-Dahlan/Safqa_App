import 'package:go_router/go_router.dart';
import 'package:safqa_app/data/models/post_model.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/add_post_step_1_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/add_post_screens/add_post_step_2_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/notifications_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/product_details_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/category_details_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/main_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/add_member_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/edit_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/membership_screen.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/more_screen/review_member_screen.dart';
import 'package:safqa_app/presentation/screens/login_screens/forget_password_screen.dart';
import 'package:safqa_app/presentation/screens/login_screens/login_screen.dart';
import 'package:safqa_app/presentation/screens/login_screens/otp_screen.dart';
import 'package:safqa_app/presentation/screens/login_screens/reset_password_screen.dart';
import 'package:safqa_app/presentation/screens/login_screens/sign_up_screen.dart';
import 'package:safqa_app/presentation/screens/onboarding_screen/onboarding_screen.dart';
import 'package:safqa_app/presentation/screens/splash_screen/splash_screen.dart';

import '../../data/models/category_model.dart';

abstract class AppRouter {
  static const kOnBoardingScreen = '/onBoardingScreen';
  static const kSignupScreen = '/signupScreen';
  static const kLoginScreen = '/loginScreen';
  static const kForgetPasswordScreen = '/forgetPasswordScreen';
  static const kResetPasswordScreen = '/resetPasswordScreen';
  static const kOTPScreen = '/otpScreen';
  static const kMainScreen = '/mainScreen';
  static const kCategoryDetailsScreen = '/categoryDetails';
  static const kProductDetailsScreen = '/postDetails';
  static const kNotificationsScreen = '/notificationsScreen';
  static const kAddPostStep1Screen = '/addPostStep1Screen';
  static const kAddPostStep2Screen = '/addPostStep2Screen';
  static const kMembershipScreen = '/membershipScreen';
  static const kAddMemberScreen = '/addMemberScreen';
  static const kReviewScreen = '/reviewScreen';
  static const kEditScreen = '/editScreen';

  static final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kOnBoardingScreen,
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: kSignupScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: kLoginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kForgetPasswordScreen,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: kResetPasswordScreen,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: kOTPScreen,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: kMainScreen,
        builder: (context, state) {

          return  MainScreen();
        }
      ),
      GoRoute(
        path: kCategoryDetailsScreen,
        builder: (context, state){
          final categoryModel= state.extra as CategoryModel;
          return CategoryDetailsScreen(categoryModel:categoryModel);
        },
      ),

      GoRoute(
        path: kProductDetailsScreen,
        builder: (context, state){
          print(state.extra);
          final postModel= state.extra as PostModel;
          return ProductDetailsScreen(postModel:postModel);
        },
      ),
      GoRoute(
        path: kNotificationsScreen,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: kAddPostStep1Screen,
        builder: (context, state) => const AddPostStep1Screen(),
      ),
      GoRoute(
        path: kAddPostStep2Screen,
        builder: (context, state) => const AddPostStep2Screen(),
      ),
      GoRoute(
        path: kMembershipScreen,
        builder: (context, state) => const MembershipScreen(),
      ),
      GoRoute(
        path: kAddMemberScreen,
        builder: (context, state) => const AddMemberScreen(),
      ),
      GoRoute(
        path: kReviewScreen,
        builder: (context, state) => const ReviewMemberScreen(),
      ),
      GoRoute(
        path: kEditScreen,
        builder: (context, state) => const EditScreen(),
      ),
    ],
  );
}
