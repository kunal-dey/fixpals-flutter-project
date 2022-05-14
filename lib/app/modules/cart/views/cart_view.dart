import 'package:fixpals/app/data/models/cart.dart';
import 'package:fixpals/app/global_widgets/bottom_cart_total.dart';
import 'package:fixpals/app/modules/category/controllers/category_controller.dart';
import 'package:fixpals/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/constants/palette.dart';

import '../../../data/models/service.dart';
import '../../../global_widgets/service_blocks/service_block.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar cartAppBar = customAppBar(
      [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
        )
      ],
      Container(
        color: white,
        height: MediaQuery.of(context).size.height * 0.045,
        alignment: Alignment.center,
        child: const Text(
          " Cart ",
          style: TextStyle(color: midnightGreen),
        ),
      ),
      IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios_new, color: cafeAuLait),
      ),
    );
    return Scaffold(
      appBar: cartAppBar,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9 -
                cartAppBar.preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: midnightGreen,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          FittedBox(
                            child: Text(
                              "Selected Services",
                              textScaleFactor: 1.2,
                              style: TextStyle(color: midnightGreen),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "Verify and swipe right to delete services",
                              textScaleFactor: 0.8,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  ...servicesInCart()
                      .map((service) => Dismissible(
                            key: GlobalKey(),
                            onDismissed: (_) {
                              removeServiceFromCart(service.id);
                            },
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              child: const Icon(
                                Icons.delete,
                                color: dark,
                              ),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05),
                            ),
                            child: Card(
                              elevation: 3,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width,
                                child: ProductCard(
                                  service: service,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
          const BottomSubTotalBar(
            route: Routes.BOOKINGS,
          )
        ],
      ),
    );
  }
}

AppBar customAppBar(
    List<Widget> tabIcons, Widget navBarTitle, Widget leadingIcon) {
  return AppBar(
    elevation: 0,
    leading: leadingIcon,
    title: navBarTitle,
    actions: tabIcons,
    backgroundColor: white,
  );
}
