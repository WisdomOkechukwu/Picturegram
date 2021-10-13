// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:demo/leadToloading.dart';
import 'package:demo/screens/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image(
          image: AssetImage('assets/hi.png'),
          height: 1000,
          width: 1000,
        ),
        nextScreen: LeadToLoading(),
        duration: 4000,
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
