import 'package:fixpals/app/global_widgets/home_grid/list_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/palette.dart';
import '../data/models/service.dart';
import 'service_blocks/service_block.dart';

///Here popular search is used for search results
class PopularSearches extends StatelessWidget {
  final double? horizontalWidth;
  final double? horizontalHeight;
  const PopularSearches({
    Key? key,
    this.horizontalHeight,
    this.horizontalWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fetchPopularServices();
    return Obx(
      () => popularServices.value.isEmpty
          ? const CircularProgressIndicator(color: cafeAuLait)
          : Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: aliceBlue,
              ),
              child: SizedBox(
                child: SizedBox(
                  width: horizontalWidth,
                  height: horizontalHeight,
                  child: Column(
                    children: [
                      const ListHeading(
                        listName: "Popular Searches",
                        color: aliceBlue,
                        textColor: midnightGreen,
                      ),
                      ...popularServices.value.map((popularSearch) {
                        return Container(
                          color: white,
                          child: ProductBlock(
                            screenHeight: MediaQuery.of(context).size.height,
                            screenWidth: MediaQuery.of(context).size.width,
                            popularService: popularSearch,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
