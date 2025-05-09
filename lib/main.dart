import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safqa_app/core/api/api_auth_service.dart';
import 'package:safqa_app/core/services/device_service.dart';
import 'package:safqa_app/core/utils/app_router.dart';
import 'package:safqa_app/data/auth_cubit/auth_cubit.dart';
import 'package:safqa_app/data/home_cubit/home_cubit.dart';
import 'package:safqa_app/data/repos/auth_repo.dart';
import 'package:safqa_app/data/repos/home_repo.dart';
import 'package:safqa_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DeviceService.getDeviceInfo();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('ar'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(AuthRepository()),
          ),
          BlocProvider(
            create: (context) => HomeCubit(HomeRepository())..loadHomeData(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: Locale('ar'),
          debugShowCheckedModeBanner: false,
          title: 'Safqa App',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: 'Montserrat-Arabic',
              // textTheme: GoogleFonts.montserratTextTheme(),
              scaffoldBackgroundColor: Colors.white),
        ),
      ),
    );
  }
}
