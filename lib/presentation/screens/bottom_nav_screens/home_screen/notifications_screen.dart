import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqa_app/core/constants.dart';
import 'package:safqa_app/core/utils/styles.dart';
import 'package:safqa_app/presentation/screens/bottom_nav_screens/home_screen/widgets/notification_widget.dart';
import 'package:safqa_app/presentation/widgets/arrow_back_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
        backgroundColor: kScaffoldColor,
        title: Text('الإشعارات', style: TextStyles.appBarTitle),
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: arrowBackWidget(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 32,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: const [
                  NotificationWidget(),
                  NotificationWidget(),
                  NotificationWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
