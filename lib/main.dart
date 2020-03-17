
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabbar/providers/HomeProvider.dart';
import 'package:sabbar/screens/HomePage.dart';
import 'package:sabbar/screens/SplashScreenPage.dart';
import 'package:sabbar/utilities/Constants.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(

      providers: [
        ChangeNotifierProvider<HomeProvider>.value(
            value: HomeProvider()
        ),
      ],

      child: MaterialApp(
        title: 'Handover',
        theme: ThemeData(
          primaryColor: Constants.appOrange,
        ),

        home: SplashScreenPage(),

        routes: {
          '/SplashScreenPage': (context) => SplashScreenPage(),
          '/HomePage': (context) => HomePage(),
        },

      ),
    );
  }
}


