import 'package:fixpals/app/data/models/service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/palette.dart';
import '../../../data/models/category.dart';
import '../../../data/models/sub_category.dart';
import '../../../global_widgets/bottom_cart_total.dart';
import '../../../global_widgets/home_grid/list_heading.dart';
import '../../../global_widgets/parallax_box.dart';
import '../../../global_widgets/service_blocks/service_block.dart';
import '../../../routes/app_pages.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  final Category category = Get.arguments["category"];
  final SubCategory subCategory = Get.arguments["subCategory"];

  CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.fetchServices(subCategory.id);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildMainSegment(context),
            const BottomSubTotalBar(
              route: Routes.CART,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMainSegment(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9 -
          MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      color: white,
      child: Stack(children: [
        CustomScrollView(
          slivers: [
            _parallaxAppBar(context),
            _categoryHeading(context),
            _selectServicesText(context),
            subCategory.subCategoryName != "no_type"
                ? _serviceNote()
                : SliverToBoxAdapter(
                    child: Container(),
                  ),
            Obx(() => controller.services.value.isNotEmpty
                ? _specificService(context)
                : SliverToBoxAdapter(child: Container())),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            )
          ],
        ),
      ]),
    );
  }

  SliverToBoxAdapter _serviceNote() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Note",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "-   Booking can be cancelled within 15 minutes. Cancellation can't be done after that.",
              softWrap: true,
              style: GoogleFonts.poppins(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "-   Booking is only applicable for repair works and minor installations.",
              softWrap: true,
              style: GoogleFonts.poppins(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "-   Timer will start once the expert reaches your doorstep.",
              softWrap: true,
              style: GoogleFonts.poppins(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "-   Material Cost (if required) is not included.",
              softWrap: true,
              style: GoogleFonts.poppins(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "-   If slot time for 3hrs exceeds beyond 30 mins, then slot will automatically get shifted to 6hrs.",
              softWrap: true,
              style: GoogleFonts.poppins(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _specificService(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width,
          color: aliceBlue,
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.001,
            horizontal: MediaQuery.of(context).size.width * 0.01,
          ),
          child: Container(
            color: white,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            child: ProductCard(service: controller.services.value[index]),
          ),
        ),
        childCount: controller.services.value.length,
      ),
    );
  }

  Widget _selectServicesText(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: cafeAuLait,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FittedBox(
                  child: Text(
                    "Choose Services",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: dark),
                  ),
                ),
                FittedBox(
                  child: Text(
                    "Add services to cart",
                    textScaleFactor: 0.9,
                    style: TextStyle(color: dark),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _categoryHeading(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02),
        child: ListHeading(
          listName: category.categoryName +
              (subCategory.subCategoryName != "no_type"
                  ? ("   (" + subCategory.subCategoryName + ")")
                  : ""),
          color: white,
          textColor: midnightGreen,
          textFontSize: 30,
        ),
      ),
    );
  }

  Widget _parallaxAppBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      floating: false,
      backgroundColor: Colors.transparent,
      leading: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(20)),
        child: FittedBox(
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: midnightGreen,
            ),
          ),
        ),
      ),
      flexibleSpace: CategoryImage(
        imageUrl: category.categoryCarouselImageUrl,
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.2,
          ),
          child: Container()),
    );
  }
}

class CategoryImage extends StatelessWidget {
  CategoryImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        child: Stack(
          children: [
            _buildParallaxBackground(context),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.6, 0.95],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
        delegate: ParallaxFlowDelegate(
          scrollable: Scrollable.of(context)!,
          insideItemContext: context,
          backgroundImageKey: _backgroundImageKey,
        ),
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1),
            key: _backgroundImageKey,
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ]);
  }
}
