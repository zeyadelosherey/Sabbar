

import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sabbar/utilities/Constants.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);


  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}



class _SplashScreenPageState extends State<SplashScreenPage> with TickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appWhite,
      body: Center(
        child: SizedBox(
          child: ColorizeAnimatedTextKit(
              isRepeatingAnimation: false,
              speed: Duration(milliseconds: 120),

              onFinished: (){
                Navigator.pushReplacementNamed(context, "/HomePage");
              },
              text: [
                "Handover",
                "Pickup",
                "Deliver",
              ],
              textStyle: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold
              ),
              colors: [
                Constants.appOrange,
                Colors.orange,
                Colors.yellow,
                Colors.deepOrangeAccent,
              ],
              textAlign: TextAlign.start,
              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
          ),
        )
      )
    );
  }
}
