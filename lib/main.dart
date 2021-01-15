import 'dart:async';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:Do.it/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: HomePage(),
        loadingText: new Text(
          "Do.it",
          style: TextStyle(
            fontFamily: "Averta",
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4285F4),
          ),
        ),
        image: new Image.asset('assets/icon1.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 30.0,
        useLoader: false,
      ),
    );
  }
}

/*class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Timer(Duration(seconds: 2), HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              child: Image.asset('assets/icon1.png'),
            ),
            SizedBox(
              height: 300,
            ),
            Container(
              child: Text(
                "Do.it",
                style: TextStyle(
                  fontFamily: "Averta",
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF171717),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
