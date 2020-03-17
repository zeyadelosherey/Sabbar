import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeServices {

  static LatLng pickup = LatLng(30.0424726,30.9754028);
  static LatLng delivery =  LatLng(29.9362123,30.9148672);
  static LatLng driver = LatLng(29.9628891,31.2494736);
  static List<LatLng> driverPath =  [
    LatLng(29.964792, 31.012385),
    LatLng(30.038687, 30.985855),
    LatLng(30.0424726,30.9754028),
    LatLng(30.019132, 30.929925),
    LatLng(29.988084, 30.897658),
    LatLng(29.943913, 30.905542),
    LatLng(29.9362123,30.9148672),
  ];


}