import 'dart:async';

import 'package:a_labs/my_another_app.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 3), // Adjust the duration as needed
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyAnotherApp(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal, // Adjust the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset("assets/images/splash.png")
            ),
            const Text(
              'Data Visualization',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]

        ),
      ),
    );
  }
}
