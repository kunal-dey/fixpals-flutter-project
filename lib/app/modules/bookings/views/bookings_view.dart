import 'package:fixpals/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: ElevatedButton(
          child: const Text("Address"),
          onPressed: () {
            Get.toNamed(Routes.ADDRESS);
          },
        ),
      ),
    );
  }

  Widget makeDismissible(BuildContext context, {required Widget child}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Get.back();
        },
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: child,
        ),
      );
}
