import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/controllers.dart';

import '../../../data/models/latlong_data.dart';

class AddressController extends GetxController {
  final Rx<LatLng?> _selectedPoint = Rx<LatLng?>(null);
  final Rx<String> address = Rx<String>("");
  final Rx<double> zoom = Rx<double>(16);
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    startTracking();
  }

  LatLng? get selectedPoint => _selectedPoint.value;

  set selectedPoint(LatLng? point) => _selectedPoint.value = point;

  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    print(address);
    print(selectedPoint);
  }

  void startTracking() async {
    if (await locationController.requestPermissions()) {
      locationController.subscribePosition(LocationAccuracy.best);
    }
  }

  Rx<LatlngData?> get currentLocation {
    //all the data of location Controller will be received in this controller
    return locationController.currentLocation;
  }

  @override
  void onClose() {
    //dispose the controller as it will again be created for other controllers
    locationController.unsubscribePosition();
  }
}
