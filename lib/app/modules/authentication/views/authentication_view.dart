import 'package:fixpals/app/core/constants/palette.dart';
import 'package:fixpals/app/modules/authentication/widgets/login/login_page.dart';
import 'package:fixpals/app/modules/authentication/widgets/otp_verification/otp_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Obx(
        () => Stack(
          children: [
            _background(context),

            //Top page containing the actual screen
            controller.getLoginStatus() == LoginStatus.phoneNumberInput
                ? LoginPage(controller: controller)
                : OTPpage(controller: controller),
            controller.getLoginStatus() == LoginStatus.otpInput
                ? _backButton(context)
                : Container(),
          ],
        ),
      ),
    );
  }

  //background image to be shown in the login and otp pages
  Widget _background(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [lightOrange, lightOrange],
        ),
      ),
    );
  }

  //back button in the otp verification page
  Widget _backButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: const BoxDecoration(
        color: Color(0x00EEEEEE),
      ),
      child: Align(
        alignment: const AlignmentDirectional(-0.95, 0),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: midnightGreen,
            size: 30,
          ),
          onPressed: () {
            controller.setLoginStatus(LoginStatus.phoneNumberInput);
          },
        ),
      ),
    );
  }
}
