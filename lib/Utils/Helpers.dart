import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Helpers {

  //@TODO calculate distance between two positions ( function return the distance in KM )
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }


  //@TODO show notification
  static showNotification(message , flutterLocalNotificationsPlugin) async {
    var android = new AndroidNotificationDetails(
      "handover",
      "handover",
      "handover",
      enableVibration: true,
      channelShowBadge: true,
      playSound: true,
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, message, "", platform, payload: message);
  }



  //@TODO control action when user click on notification
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }


}