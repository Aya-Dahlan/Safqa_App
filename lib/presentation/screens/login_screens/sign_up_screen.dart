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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final authCubit = context.read<AuthCubit>();
      context.read<AuthCubit>().register(
            _nameController.text.trim(),
            _phoneController.text.trim(),
            _passwordController.text,
            _confirmPasswordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            // 🟢 عند نجاح التسجيل، طلب كود الـ OTP
            final authCubit = context.read<AuthCubit>();
            await authCubit.sendOtp(_phoneController.text);
            GoRouter.of(context).push(AppRouter.kOTPScreen);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  arrowBackWidget(context),
                  SizedBox(height: 32.h),
                  const titleTextWidget(title: 'إنشاء حساب'),
                  SizedBox(height: 12.h),
                  const descriptionWidget(
                    text:
                        'انضم إلينا واستمتع بتجربة تسوق مميزة وفرص بيع لا حدود لها!',
                  ),
                  SizedBox(height: 24.h),
                  CustomTextField(
                    hintText: 'الاسم',
                    textEditingController: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال الاسم';
                      } else if (value.length < 3) {
                        return 'يجب أن يحتوي الاسم على 3 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    hintText: 'رقم الجوال',
                    textEditingController: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال رقم الجوال';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    hintText: 'كلمة المرور',
                    textEditingController: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال كلمة المرور';
                      } else if (value.length < 6) {
                        return 'يجب أن تحتوي كلمة المرور على 6 أحرف على الأقل';
                      } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d).{6,}$')
                          .hasMatch(value)) {
                        return 'يجب أن تحتوي كلمة المرور على حرف كبير ورقم';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    hintText: 'تأكيد كلمة المرور',
                    isPassword: true,
                    textEditingController: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى تأكيد كلمة المرور';
                      } else if (value != _passwordController.text) {
                        return 'كلمة المرور غير متطابقة';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.h),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                          title: state is AuthLoading
                              ? 'جاري التسجيل...'
                              : 'إنشاء الحساب',
                          onTap: state is AuthLoading ? () {} : _submitForm);
                    },
                  ),
                  SizedBox(height: 127.h),
                  footerWidget(
                    text1: ' لديك حساب؟ ',
                    text2: 'تسجيل الدخول',
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kLoginScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
