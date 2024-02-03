import 'dart:async';

import 'package:finance/colors/colors.dart';
import 'package:finance/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset('assets/svg/logo.svg'),
          SizedBox(
            height: 40,
          ),
          Text(
            "Finance",
            style: TextStyle(
                fontSize: 24,
                color: kPrimaryGreen,
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
