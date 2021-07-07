import 'dart:async';

import 'package:filli/Auth/SignupPage.dart';
import 'package:filli/Auth/loginPage.dart';
import 'package:filli/pages/GeneralScreen.dart';
import 'package:filli/pages/ProfileScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'filli',
      theme: ThemeData(
        backgroundColor: const Color(0xffffffff),
        scaffoldBackgroundColor: const Color(0xffffffff),
        hintColor: const Color(0xff9C9C9D),
        primaryColorLight: const Color(0xffF7F7F7),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => SignupPage(),
        '/profile': (BuildContext context) => ProfileScreen(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.lightBlue.shade100,
            );
          }
          if (snapshot.hasData) {
            return GeneralScreen();
          }
          return LoginPage();
        },
      ),
    );
  }
}
