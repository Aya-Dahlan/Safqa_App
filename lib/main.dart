import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _setupFirebaseMessaging();
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

Future<void> _setupFirebaseMessaging() async {
  // Set the background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Request permission for iOS
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission (required for iOS)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  // Get the token
  try {
    String? token = await messaging.getToken();
    print('FCM Token: $token');

    // For iOS, specifically check for APNS token
    String? apnsToken = await messaging.getAPNSToken();
    print('APNS Token: $apnsToken');

    // If the APNS token is null on iOS, it might not be ready yet
    if (apnsToken == null) {
      print("APNS token not available yet. This is normal during initialization.");
      // You can set up a listener to get the token when it becomes available
      messaging.onTokenRefresh.listen((token) {
        print('FCM token refreshed: $token');
      });
    }
  } catch (e) {
    print('Error getting FCM token: $e');
  }

  // Configure foreground message handling
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
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
            create: (context) => HomeCubit(HomeRepository())..loadHomeData()..getMyFavorites(),
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
