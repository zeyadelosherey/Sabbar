import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sabbar/Model/HomeModel.dart';
import 'package:sabbar/Utils/Helpers.dart';



enum Point {
  WAY,
  PICKUP,
  NEAR,
  DELIVERED,
}


class HomeProvider with ChangeNotifier {

  LatLng _delivery = HomeModel.delivery ;
  LatLng _pickup = HomeModel.pickup ;
  LatLng _driver = HomeModel.driver  ;
  List<LatLng> _driverPath = HomeModel.driverPath;
  Point _point = Point.WAY;
  bool _showOrderTrackWidget = true;


  getDelivery() => _delivery;
  getPickup() => _pickup;
  getDriver() => _driver;
  getPoint() => _point;
  getShowOrderTrackWidget() => _showOrderTrackWidget;




  Future changeDriverPosition(flutterLocalNotificationsPlugin , controller , ){

    //Change driver location
     int i = 0 ;
     Timer.periodic(Duration(seconds: 2),  (timer){
       _driver = _driverPath[i];
       controller.animateCamera(CameraUpdate.newCameraPosition(
         CameraPosition(
             target:  _driver,
             zoom: 11
         ),
       ));
       notifyListeners();
       i++;


       //Check positions of driver
       if(_pickup == _driver){
         Helpers.showNotification("driver at point", flutterLocalNotificationsPlugin);
         _point = Point.PICKUP;
       }else if(_delivery == _driver){
         Helpers.showNotification("driver here", flutterLocalNotificationsPlugin);
       _point = Point.DELIVERED;
       _showOrderTrackWidget = false;
       }
       else if(Helpers.calculateDistance(_pickup.latitude,_pickup.longitude, _driver.latitude , _driver.longitude) == 0.001){
         Helpers.showNotification("driver near from you", flutterLocalNotificationsPlugin);
       }else if(Helpers.calculateDistance(_pickup.latitude,_pickup.longitude, _driver.latitude , _driver.longitude) <= 5){
         Helpers.showNotification("driver 5k from you", flutterLocalNotificationsPlugin);
       }else if(Helpers.calculateDistance(_delivery.latitude,_delivery.longitude, _driver.latitude , _driver.longitude) == 0.001){
         Helpers.showNotification("driver near from delivery point", flutterLocalNotificationsPlugin);
         _point = Point.NEAR;
       }else if(Helpers.calculateDistance(_delivery.latitude,_delivery.longitude, _driver.latitude , _driver.longitude) <= 5){
         Helpers.showNotification("driver 5k from delivery point", flutterLocalNotificationsPlugin);
         _point = Point.NEAR;
       }

       //Cancel Timer
       if(i == 7){
         timer.cancel();
       }
     });
  }


}

