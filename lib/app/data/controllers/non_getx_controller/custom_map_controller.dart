import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart' show Geolocator, Position;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/controllers.dart';

class CustomMapController extends GetxController {
  MapController _mapController = MapController();

  @override
  void onInit() {
    super.onInit();
    //_customMapController = CustomMapController(toUpdateUI: updateUI);
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      moveTheMap(location: locationController.currentLocation.value?.location);
    });
  }

  void moveTheMap({LatLng? location}) {
    if (location != null) {
      _mapController.move(LatLng(location.latitude, location.longitude), 16.0);
    }
  }

  MapController get mapController {
    return _mapController;
  }
}
