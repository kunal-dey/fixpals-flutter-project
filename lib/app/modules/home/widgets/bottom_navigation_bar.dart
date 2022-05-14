import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/palette.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class BottomNavBar extends GetWidget<HomeController> {
  const BottomNavBar({Key? key}) : super(key: key);

  void navigate(value) {
    switch (value) {
      case 0:
        break;
      case 1:
        Get.toNamed(Routes.BOOKINGS);
        break;
      case 2:
        Get.toNamed(Routes.PROFILE);
        break;
      case 3:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        onTap: (value) {
          controller.currentIndex.value = 0;
          navigate(value);
        },
        elevation: 2,
        currentIndex: controller.currentIndex.value,
        unselectedItemColor: midnightGreen.withAlpha(190),
        selectedItemColor: midnightGreen,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 24,
        items: [
          [Icons.home, "Home"],
          [Icons.book_outlined, "Orders"],
          [Icons.settings, "Profile"],
          [Icons.notifications, "Notifications"],
        ]
            .map(
              (bottomNavList) => BottomNavigationBarItem(
                backgroundColor: lightOrange,
                icon: Icon(
                  bottomNavList[0] as IconData,
                  color: midnightGreen.withAlpha(180),
                ),
                activeIcon: Icon(
                  bottomNavList[0] as IconData,
                  color: midnightGreen,
                ),
                label: bottomNavList[1] as String,
              ),
            )
            .toList(),
      ),
    );
  }
}
