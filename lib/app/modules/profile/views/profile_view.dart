import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/constants/palette.dart';
import '../../../global_widgets/static_content/static_page_heading.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  white,
                  Colors.grey,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          StaticPageHeading(headingName: "Profile"),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: cafeAuLait,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 1),
                      color: Colors.grey)
                ],
              ),
              child: LayoutBuilder(
                builder: (ctx, constraints) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.1,
                      vertical: constraints.maxHeight * 0.1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: {
                        "Full Name": "Kunal Dey",
                        "Email Address": "kunaldeybgp1@gmail.com",
                        "Phone Number": " 9264112071",
                        "Address":
                            "Nomadic by heart, trapped by economic bindings"
                      }
                          .map(
                            (key, value) => MapEntry(
                              key,
                              profileRow(key, value),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileRow(String item, String itemValue) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Text(
            item,
            textScaleFactor: 1.1,
            style: TextStyle(
              color: white,
            ),
          ),
        ),
        Expanded(child: Container()),
        Flexible(
          child: Text(
            ":",
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.1,
          ),
        ),
        Spacer(),
        Flexible(
          flex: 5,
          child: Text(
            itemValue,
            textScaleFactor: 1.1,
          ),
        )
      ],
    );
  }
}
