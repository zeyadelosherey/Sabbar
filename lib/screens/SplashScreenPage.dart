

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sabbar/utilities/Constants.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);


  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}



class _SplashScreenPageState extends State<SplashScreenPage> with TickerProviderStateMixin{
  Animation<double> textAnimation;
  AnimationController textAnimationController;
  @override
  void initState() {
    // TODO: implement initState
    textAnimationController = AnimationController(vsync: this , duration: Duration(milliseconds: 700));
    textAnimation = Tween<double>(begin: 0.0 , end: 1.0).animate(CurvedAnimation(parent: textAnimationController, curve: Curves.easeOut));
    textAnimation.addStatusListener((state) {
      if(state.index == 3 )
       Navigator.pushReplacementNamed(context, "/HomePage");
    });

    textAnimation.addListener((){setState(() {});});
    textAnimationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appOrange,
      body: Center(
        child: Text("Handover" ,   style: TextStyle(fontSize: textAnimation.value * 50, color: Constants.appWhite, fontWeight: FontWeight.bold),),
      )
    );
  }
}
