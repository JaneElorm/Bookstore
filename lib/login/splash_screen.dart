import 'package:flutter/material.dart';
import 'package:mobile_app_final/homepage/Homepage.dart';
import 'package:mobile_app_final/login/login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
       // MaterialPageRoute(builder: (context) => LoginPage()),
       MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('images/Screenshot 2024-07-24 145413.png'), // Update the path if needed
      ),
    );
  }
}
