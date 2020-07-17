import 'package:geolocator/geolocator.dart';

class Locations {
  double latitude;
  double longitude;

  Future<void> getLocations() async {
    try {
      Position position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
