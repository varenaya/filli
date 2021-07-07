import 'package:filli/Auth/SignupPage.dart';
import 'package:filli/Auth/loginPage.dart';
import 'package:filli/pages/GeneralScreen.dart';
import 'package:filli/pages/ProfileScreen.dart';
import 'package:filli/services/usermanagement.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return UserManagement().handleAuth();
          }),
    );
  }
}
