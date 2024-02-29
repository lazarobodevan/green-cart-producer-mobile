import 'package:location/location.dart';

abstract class BaseGeolocationRepository{
  Future<LocationData?> getCurrentLocation() async{}
}