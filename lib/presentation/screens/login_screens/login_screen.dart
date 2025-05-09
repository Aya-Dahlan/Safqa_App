import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/data/auth_cubit/auth_cubit.dart';
import 'package:safqa_app/data/auth_cubit/auth_state.dart';
import 'package:safqa_app/presentation/screens/login_screens/widgets/description_widget.dart';
import 'package:safqa_app/presentation/screens/login_screens/widgets/footer_widget.dart';
import 'package:safqa_app/presentation/screens/login_screens/widgets/title_text_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_button_widget.dart';
import 'package:safqa_app/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isChecked = false; // الحالة الافتراضية للصندوق

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
                width: double.infinity,
              ),
              arrowBackWidget(context),
              SizedBox(
                height: 32.h,
              ),
              const titleTextWidget(title: 'أهلا بك في صفقة'),
              SizedBox(
                height: 12.h,
              ),
              const descriptionWidget(
                  text: 'مرحبًا بعودتك! ادخل لتواصل البيع والشراء بكل سهولة.'),
              SizedBox(
                height: 29.h,
              ),
              CustomTextField(
                hintText: 'رقم الجوال',
                textEditingController: phoneController,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomTextField(
                hintText: 'كلمة المرور',
                isPassword: true,
                textEditingController: passController,
              ),
              SizedBox(
                height: 19.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                        checkboxTheme: CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(4), // إضافة حواف دائرية بقيمة 4
                    ))),
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // إزالة المساحة الإضافية حول الزر

                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          if (states.contains(MaterialState.selected)) {
                            return kPrimaryColor; // لون الصندوق عند التحديد ✅
                          }
                          return Color(0xffD0D1D2).withOpacity(
                              0.4); // لون الصندوق عند عدم التحديد ⬜
                        },
                      ),
                      activeColor: kPrimaryColor, // لون عند التحديد,
                      side: BorderSide.none,
                    ),
                  ),
                  Text(
                    'تذكرني',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: kPrimaryColor,
                      letterSpacing: 0 / 100,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context)
                          .push(AppRouter.kForgetPasswordScreen);
                    },
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff2E5579),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 86.h,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم تسجيل الدخول بنجاح!')),
                    );
                    GoRouter.of(context).push(AppRouter.kMainScreen);
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${state.message}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomButton(
                    onTap: () {
                      final phone = phoneController.text;
                      final password = passController.text;
                      context.read<AuthCubit>().login(phone, password);
                    },
                    title: 'تسجيل الدخول',
                  );
                },
              ),
              SizedBox(
                height: 178.h,
              ),
              footerWidget(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kSignupScreen);
                  }, text1: ' ليس لديك حساب؟ ', text2: 'إنشاء حساب'),
            ],
          ),
        ),
      ),
    );
  }
}
