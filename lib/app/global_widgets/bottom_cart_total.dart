import 'package:fixpals/app/data/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/palette.dart';
import '../routes/app_pages.dart';

class BottomSubTotalBar extends StatelessWidget {
  final String route;
  const BottomSubTotalBar({
    required this.route,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: lightOrange,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(-1, -1),
            ),
          ]),
      child: LayoutBuilder(
        builder: (ctx, constraints) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.8,
              width: constraints.maxWidth * 0.6,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FittedBox(
                          child: Text(
                            "Sub Total",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: midnightGreen),
                            textScaleFactor: 1.2,
                          ),
                        ),
                        Obx(() {
                          Rx<double> totalAmount = Rx<double>(0);
                          if (cart.value.keys.isNotEmpty) {
                            for (var element in cart.value.keys) {
                              if (cart.value[element] != null &&
                                  cart.value[element]!.service != null) {
                                totalAmount +=
                                    cart.value[element]!.quantity.value *
                                        cart.value[element]!.service!.salePrice;
                              }
                            }
                          }
                          return FittedBox(
                            child: Text(
                              totalAmount.toString(),
                              textScaleFactor: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: midnightGreen,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ]),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                route != Routes.CART
                    ? Get.toNamed(Routes.BOOKINGS)
                    : Get.toNamed(Routes.CART);
              },
              child: Container(
                height: constraints.maxHeight * 0.4,
                width: constraints.maxWidth * 0.35,
                padding: EdgeInsets.all(constraints.maxHeight * 0.08),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: princetonOrange,
                ),
                child: FittedBox(
                  child: Text(
                    Get.currentRoute == Routes.CART ? "CHECKOUT" : "CART",
                    style: const TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
