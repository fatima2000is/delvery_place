import 'package:delverplace/core/thems.dart';
import 'package:delverplace/src/controller/SearchController.dart';
import 'package:delverplace/src/controller/bottom_bar.dart';
import 'package:delverplace/src/controller/connectionmanager.dart';
import 'package:delverplace/src/controller/fonctions.dart';
import 'package:delverplace/src/controller/toggle_theme_controller.dart';
import 'package:delverplace/src/view/screen/find_leads.dart';
import 'package:delverplace/src/view/screen/login.dart';
import 'package:delverplace/src/view/widget/scanner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  ThemeToggleController controller = Get.put(ThemeToggleController());
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkController());
  Get.put(SerachController());
  Get.put(inzajController());
  Get.put(BottomNavigationBarController());
  Get.put(ThemeToggleController());

  await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: controller.getThemeMode(),
            theme: MyThemes.lightThem,
            darkTheme: MyThemes.darkTheme,
            title: 'Flutter delvery',
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/': (context) => const Login(),
              'scan': (context) => const ScannerCode(),
              // When navigating to the "/second" route, build the SecondScreen widget.
              '/second': (context) => const FindLeadsScreen(),
            },
            initialRoute: '/',
          ),
        ),
      ));
}
