import 'package:delverplace/src/model/bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppData {
  const AppData._();

  static const Color pinkcolor = Colors.orange;

  static List<BottomNavigationItem> bottomNavigationItems(
      bool isDark, isSelected) {
    List<BottomNavigationItem> itemlist = [
      BottomNavigationItem(
          Icon(
            Icons.home,
            color: isSelected == 0
                ? pinkcolor
                : (isDark ? Colors.white : const Color(0xff011842)),
          ),
          'Home'),
      BottomNavigationItem(
          SvgPicture.asset(
            "assets/icons/search.svg",
            width: 24.0,
            height: 24.0,
            color: isSelected == 1
                ? pinkcolor
                : (isDark ? Colors.white : const Color(0xff011842)),
          ),
          'Search'),
      BottomNavigationItem(
          SvgPicture.asset(
            "assets/icons/alldeals.svg",
            width: 24.0,
            height: 24.0,
            color: isSelected == 2
                ? pinkcolor
                : (isDark ? Colors.white : const Color(0xff011842)),
          ),
          'Deals'),
      BottomNavigationItem(
          SvgPicture.asset(
            "assets/icons/settings.svg",
            width: 24.0,
            height: 24.0,
            color: isSelected == 3
                ? pinkcolor
                : (isDark ? Colors.white : const Color(0xff011842)),
          ),
          'Settings')
    ];

    return itemlist;
  }
}
