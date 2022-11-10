import 'package:location/location.dart';
export 'package:location/location.dart' show LocationData;

class LocationService {
  final _location = Location();

  Future<LocationData> getLocationData() async {
    return await _location.getLocation();
  }

  Future<bool> serviceEnabled() async {
    return await _location.serviceEnabled();
  }

  Future<bool> hasPermission() async {
    var _permission = await _location.hasPermission();
    return _permission == PermissionStatus.granted;
  }
}
