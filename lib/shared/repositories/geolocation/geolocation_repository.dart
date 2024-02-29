
import 'package:location/location.dart';
import 'package:mobile_producer/shared/repositories/geolocation/base_geolocation_repository.dart';

class GeolocationRepository extends BaseGeolocationRepository{
  GeolocationRepository();

  @override
  Future<LocationData?> getCurrentLocation() async{
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
    }
    _permissionGranted = await location.hasPermission();

    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();
    }

    _locationData = await location.getLocation();

    return _locationData;
  }
}