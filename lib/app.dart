import 'package:flutter/material.dart';

import 'constants/global.dart';
import 'core/themes/app_theme.dart';
import 'core/widgets/app_annotated_region.dart';
import 'routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAnnotatedRegion(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler:
              TextScaler
                  .noScaling, // keep font size as it is (not as per system fonts)
        ),
        child: MaterialApp(
          navigatorKey: Global.globalKey,
          debugShowCheckedModeBanner: false,
          title: Global.appName,
          theme: AppTheme.appTheme,
          initialRoute: Routes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: (context, child) {
            return Overlay(
              initialEntries: [OverlayEntry(builder: (context) => child!)],
            );
          },
        ),
      ),
    );
  }
}
