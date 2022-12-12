import 'package:delverplace/core/app_data.dart';
import 'package:delverplace/src/controller/bottom_bar.dart';
import 'package:delverplace/src/controller/fonctions.dart';
import 'package:delverplace/src/controller/toggle_theme_controller.dart';
import 'package:delverplace/src/view/screen/all_leads.dart';
import 'package:delverplace/src/view/screen/find_leads.dart';
import 'package:delverplace/src/view/screen/home_dashboard.dart';
import 'package:delverplace/src/view/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final List<Widget> screens = [
  const DashboardScreen(),
  const FindLeadsScreen(),
  const AllLeadsScreen(),
  const SettingsScreen()
];

class BottomNav extends StatelessWidget {
  BottomNav({super.key});
  final controller = Get.put(inzajController());

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    BottomNavigationBarController _screenindexcontroller = Get.find();
    ThemeToggleController _thememodecontroller = Get.find();

    //final _screenindexprovider =
    //  Provider.of<BottomNavigationBarProvider>(context);
    // ignore: no_leading_underscores_for_local_identifiers
    RxInt currentScreenIndex = _screenindexcontroller.fetchCurrentScreenIndex;

    return Obx(() {
      return BottomNavigationBar(
        backgroundColor: const Color.fromARGB(0, 238, 245, 249),
        unselectedItemColor: Colors.black,
        currentIndex: currentScreenIndex.value,
        showUnselectedLabels: true,
        onTap: (value) {
          _screenindexcontroller.updateScreenIndex(value);
          switch (value) {
            case 0:
              Get.to(screens[0]);

              break;
            case 1:
              Get.to(screens[1]);
              break;
            case 2:
              Get.to(screens[2]);
              break;
            case 3:
              Get.to(screens[3]);

              break;
            default:
              break;
          }

          /*if (currentScreenIndex == 0) {
            controller.dashboardData(context);
          } else if (currentScreenIndex == 0) {
            // controller.List3.clear();
          }*/
        },
        selectedItemColor: Colors.orange,
        //fixedColor: Colors.orange,
        items: AppData.bottomNavigationItems(
                _thememodecontroller.isDarkMode, currentScreenIndex.value)
            .map(
              (element) => BottomNavigationBarItem(
                  icon: element.icon,
                  backgroundColor: const Color(0xFFEEF5F9),
                  label: element.label),
            )
            .toList(),
      );
    });
  }
}
