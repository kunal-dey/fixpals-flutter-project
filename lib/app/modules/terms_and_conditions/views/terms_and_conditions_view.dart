import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../global_widgets/static_content/static_content.dart';
import '../../../global_widgets/static_content/static_page_heading.dart';
import '../controllers/terms_and_conditions_controller.dart';

import 'package:flutter/services.dart' as jsonLoadingService;

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({Key? key}) : super(key: key);

  ///to get the data from a local json files stored in the assets
  Future<List<dynamic>> readFromJsonData() async {
    final jsonData = await jsonLoadingService.rootBundle
        .loadString("assets/json_files/terms_and_conditions.json");

    return json.decode(jsonData) as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StaticPageHeading(headingName: "T&C"),
          _content(context),
        ],
      ),
    );
  }

  ///content is obtained from the json file and is shown using this widget
  Widget _content(BuildContext context) {
    return StaticContent(
      readData: readFromJsonData,
    );
  }
}
