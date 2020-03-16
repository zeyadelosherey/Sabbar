import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sabbar/Providers/HomeProvider.dart';
import 'package:sabbar/Utils/Constants.dart';
import 'package:sabbar/Utils/Helpers.dart';
import 'package:sabbar/WidgetHelper/CommomWidgets.dart';

import 'package:sabbar/WidgetHelper/SlidingPanel.dart';
import 'package:sabbar/WidgetHelper/Steps.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  Animation<double> panelAnimation;
  AnimationController panelAnimationController;
  Animation<double> imageAnimation;
  AnimationController imageAnimationController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  BitmapDescriptor  deliveryIcon;
  BitmapDescriptor  pickupIcon;
  BitmapDescriptor  driverIcon;
  PanelController panelController;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    // TODO: implement initState
    initialization();
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    panelAnimationController.dispose();
    imageAnimationController.dispose();
    panelController.close();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    var homeProvider= Provider.of<HomeProvider>(context);
    return Scaffold(
        body: Stack(
            children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 150),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(target: homeProvider.getDriver() , zoom: 9),
                    zoomGesturesEnabled: true,
                    mapToolbarEnabled: false,
                    markers: Set<Marker>.of(
                      <Marker>[
                          Marker(
                            markerId: MarkerId("delivery"),
                            position: homeProvider.getDelivery(),
                            icon: deliveryIcon,
                          ),
                          Marker(
                              markerId: MarkerId("pickup"),
                              position: homeProvider.getPickup(),
                              icon: pickupIcon,
                          ),

                          Marker(
                            markerId: MarkerId("driver"),
                            position: homeProvider.getDriver(),
                            icon: driverIcon
                          )
                      ]
                    ),


                    circles: Set<Circle>.of(
                      <Circle>[
                          Circle(
                              circleId: CircleId("delivery5km"),
                              radius: 100,
                              visible: true,
                              fillColor: Constants.deliveryFillColor,
                              strokeWidth: 1,
                              strokeColor: Constants.deliveryStrokeColor,
                              center: homeProvider.getDelivery()
                          ),
                          Circle(
                              circleId: CircleId("delivery5km"),
                              radius: 5000,
                              visible: true,
                              fillColor: Constants.deliveryFillColor,
                              strokeWidth: 1,
                              strokeColor: Constants.deliveryStrokeColor,
                              center: homeProvider.getDelivery()
                          ),
                          Circle(
                            circleId: CircleId("pickup5km"),
                            radius: 5000,
                            visible: true,
                            fillColor: Constants.pickupFillColor,
                            strokeWidth: 1,
                            strokeColor: Constants.pickupFillColor,
                            center: homeProvider.getPickup(),
                          ),
                          Circle(
                            circleId: CircleId("pickup5km"),
                            radius: 100,
                            visible: true,
                            fillColor: Constants.pickupFillColor,
                            strokeWidth: 1,
                            strokeColor: Constants.pickupFillColor,
                            center: homeProvider.getPickup(),
                          ),
                      ],
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      homeProvider.changeDriverPosition(flutterLocalNotificationsPlugin , controller);
                    },
                  ),
                ),

              Positioned(
                top: 30,
                left: 10,
                child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black, size: 30,), onPressed: () {}),
              ),


               homeProvider.getShowOrderTrackWidget() ?  trackOrderWidget(homeProvider.getPoint().index) : orderRatingWidget()
            ],
    ),


    );
  }



    void initialization() {
       BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(64, 64)), 'assets/images/delivery.png').then((icon){
        deliveryIcon = icon;
      });
       BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(64, 64)), 'assets/images/pickup.png').then((icon){
         pickupIcon = icon;
       });
       BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(64, 64)), 'assets/images/pin.png').then((icon){
         driverIcon = icon;
       });


       panelController  = new PanelController();
       panelAnimationController = AnimationController(vsync: this , duration: Duration(milliseconds: 1500));
       imageAnimationController = AnimationController(vsync: this , duration: Duration(seconds: 3));
       panelAnimation = Tween<double>(begin: 0.0 , end: 1.0).animate(CurvedAnimation(parent: panelAnimationController, curve: Curves.easeInOutCubic));
       panelAnimation.addStatusListener((state) {});
       panelAnimation.addListener((){setState(() {});});
       panelAnimationController.forward();
       imageAnimation = Tween<double>(begin: 0.0 , end: 1.0).animate(CurvedAnimation(parent: panelAnimationController, curve: Curves.bounceOut));
       imageAnimation.addStatusListener((state) {});
       imageAnimation.addListener((){setState(() {});});
       imageAnimationController.forward();




       var android = new AndroidInitializationSettings('mipmap/ic_launcher');
       var ios = new IOSInitializationSettings();
       var platform = new InitializationSettings(android, ios);
       flutterLocalNotificationsPlugin.initialize(platform);

  }


  //@TODO Create Track order widget
  Widget trackOrderWidget(step){
    return Stack(
      alignment:Alignment.center,
      children: <Widget>[
        SlidingUpPanel(
          minHeight: panelAnimation.value*270,
          maxHeight: 270,
          controller: panelController,
          color: Constants.appOrange,
          borderRadius: BorderRadius.only(topRight: Radius.circular(35), topLeft: Radius.circular(35)),
          panel: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80,),
                  Text("Mohamed Abdullah" , style: TextStyle(color: Constants.appBlack , fontSize: 16 , fontWeight: FontWeight.bold),),
                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.only(left: 50 , right: 50),
                    child: Steps(
                      selectedStep: step,
                      nbSteps: 4,
                      isHorizontal: false,
                      lineLength: 25,
                      selectedStepSize:10,
                      unselectedStepSize: 10,
                      doneStepSize: 10,
                      selectedStepColorIn: Constants.appBlack,
                      selectedStepColorOut: Constants.appBlack,
                      doneLineColor:  Constants.appBlack,
                      doneStepColor: Constants.appBlack,
                      undoneLineColor: Constants.appLineColor ,
                      unselectedStepColor: Constants.appLineColor ,
                      stepTitle: ['On the way' ,'Pick up delivery' ,'Near delivery destination' ,'Delivered Package'],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        CommonWidgets.slideImageWidget(imageAnimation , 210.0 )
      ],
    );
  }


  //@TODO Create order rating widget
  Widget orderRatingWidget(){
    return Stack(
      alignment:Alignment.center,
      children: <Widget>[
        SlidingUpPanel(
          minHeight: panelAnimation.value*400,
          maxHeight: 400,
          controller: panelController,
          color: Constants.appOrange,
          borderRadius: BorderRadius.only(topRight: Radius.circular(35), topLeft: Radius.circular(35)),
          panel: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80,),
                  Text("Mohamed Abdullah" , style: TextStyle(color: Constants.appBlack , fontSize: 16 , fontWeight: FontWeight.bold),),
                  SizedBox(height: 25,),
                  Column(
                      children: <Widget>[
                        RatingBar(
                          initialRating: 0,
                          minRating: 0,
                          direction: Axis.horizontal,
                          itemSize: 47,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.5),
                          glowColor: Constants.appOrangeRateBar,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Constants.appOrangeRateBar,
                          ),
                          onRatingUpdate: (rating) {

                          },
                        ),
                        SizedBox(height: 60,),
                        CommonWidgets.orderInformationWidget("Pickup Time", "10:00 PM", context),
                        SizedBox(height: 10,),
                        CommonWidgets.orderInformationWidget("Delivery Time", "10:30 PM", context),
                        SizedBox(height: 30,),
                        CommonWidgets.orderInformationWidget("Total", "", context),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(child: Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
                              child: Container(child: Align(alignment: Alignment.centerLeft, child: Text("\$30.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))), height: 40,),), flex: 1,),
                            Expanded(child: InkWell(
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(color: Constants.appWhite, borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(child: Align(alignment: Alignment.centerRight, child: Text("Submit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),)), flex: 2,),
                                        SizedBox(width: 50,),
                                        Expanded(child: Align(alignment: Alignment.centerLeft, child: Icon(Icons.arrow_forward)), flex: 1,),
                                      ],
                                    )
                                )
                            ),
                            )

                          ],
                        )
                      ])
                ],
              ),
            ),
          ),
        ),

        CommonWidgets.slideImageWidget(imageAnimation , 340.0 )

      ],


    );
  }

}