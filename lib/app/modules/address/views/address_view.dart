import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/address_controller.dart';
import '../../../core/constants/palette.dart';
import '../../../global_widgets/map_container.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: ultramarineBlue,
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(height: MediaQuery.of(context).padding.top),
                    _nonInputHeadingSection(constraints, context),
                    _mapSection(constraints),
                    _addressSection(constraints),
                    _submitButton(constraints)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _submitButton(BoxConstraints constraints) {
    return InkWell(
      onTap: () {
        controller.submit();
        Get.back();
      },
      child: Container(
        height: constraints.maxHeight * 0.08,
        width: constraints.maxWidth,
        decoration: const BoxDecoration(
          color: cafeAuLait,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter your address",
                style: GoogleFonts.aBeeZeeTextTheme()
                    .apply(bodyColor: white)
                    .bodyMedium),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.map,
              color: white,
            ),
          ],
        ),
      ),
    );
  }

  Form _addressSection(BoxConstraints constraints) {
    return Form(
      key: controller.formKey,
      child: Container(
        height: constraints.maxHeight * 0.14,
        width: constraints.maxWidth,
        padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.02,
            vertical: constraints.maxHeight * 0.02),
        child: TextFormField(
          keyboardType: TextInputType.streetAddress,
          decoration: const InputDecoration(
            filled: true,
            fillColor: white,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.0,
                color: ultramarineBlue,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Kindly enter the address";
            }
          },
          onSaved: (value) {
            if (value != null) controller.address.value = value;
          },
          onFieldSubmitted: (value) {
            controller.address.value = value;
          },
        ),
      ),
    );
  }

  Container _mapSection(BoxConstraints constraints) {
    return Container(
      color: Colors.transparent,
      height: constraints.maxHeight * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Obx(
        () => controller.currentLocation.value != null
            ? Stack(
                children: [
                  MapContainer(
                    controller,
                    obtainedHeight: constraints.maxHeight * 0.6,
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(color: white),
              ),
      ),
    );
  }

  Container _nonInputHeadingSection(
      BoxConstraints constraints, BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight * 0.18 - MediaQuery.of(context).padding.top,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios))
              ],
            ),
          ),
          Text(
            "Enter Your Address",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: dark,
            ),
          ),
          Text(
            "Tap on the screen to change location",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: dark,
            ),
          )
        ],
      ),
    );
  }
}
