import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:employee_attendence_app/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'home_page_screen/home_page_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  static Database? db;

  const SplashScreen({Key? key}) : super(key: key);
  static SharedPreferences? prefs;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    forGetData();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ));
    });
  }

  forGetData() async {
    SplashScreen.prefs = await SharedPreferences.getInstance();
    DataBaseHelper().getDataBase().then((value) {
      setState(() {
        SplashScreen.db = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("animations/attendance1.json"),
          ),
          const SizedBox(
            height: 100,
          ),
          AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                '''Employee Attendance''',
                textStyle: const TextStyle(
                  fontFamily: "family",
                  fontSize: 30.0,
                  color: Color(0xffffca28),
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 200),
              ),
            ],
            totalRepeatCount: 4,
            pause: const Duration(milliseconds: 100),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ],
      ),
    );
  }
}
