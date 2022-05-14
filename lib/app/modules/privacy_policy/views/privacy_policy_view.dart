import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../global_widgets/static_content/static_content.dart';
import '../../../global_widgets/static_content/static_page_heading.dart';
import '../controllers/privacy_policy_controller.dart';
import 'package:flutter/services.dart' as jsonLoadingService;

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  Future<List<dynamic>> readFromJsonData() async {
    final jsonData = await jsonLoadingService.rootBundle
        .loadString("assets/json_files/privacy_policy.json");

    return json.decode(jsonData) as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StaticPageHeading(headingName: "Privacy Policy"),
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
