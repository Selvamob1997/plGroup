import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pl_groups/app/utils/stringValues.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ((context, child) => GetMaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFFEE0A4F),
            appBarTheme: const AppBarTheme(
              color: Color(0xFFEE0A4F),
            )),
        locale: const Locale('en'),
        title: stringValues.plgroups,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        // translations: TranslationsFile(),
        // supportedLocales: TranslationsFile.listOfLocales,
        getPages: AppPages.pages,
        initialRoute: AppPages.initialpage,
        enableLog: true,
      )),
    );

  }
}


