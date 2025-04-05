import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safqa_app/core/utils/app_icons.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/data/repos/auth_repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    final isAuthenticated = await _authRepository.initializeAuth();

    if (mounted) {
      if (isAuthenticated) {
        GoRouter.of(context).pushReplacement(AppRouter.kMainScreen);
      } else {
        GoRouter.of(context).pushReplacement(AppRouter.kSignupScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ksplashColor,
      body: Center(
        child: SvgPicture.asset(AppIcons.logo),
      ),
    );
  }
}
