import 'dart:async';

import 'package:filli/Auth/SignupPage.dart';
import 'package:filli/Auth/loginPage.dart';
import 'package:filli/Screens/AddLobbyScreen.dart';
import 'package:filli/Screens/CreateLobbyScreen.dart';
import 'package:filli/Screens/FilesScreen.dart';
import 'package:filli/Screens/GeneralScreen.dart';
import 'package:filli/Screens/LinksScreen.dart';
import 'package:filli/Screens/NotesScreen.dart';
import 'package:filli/Screens/ProfileScreen.dart';
import 'package:filli/Screens/ProjectOverviewScreen.dart';
import 'package:filli/Screens/TodScreen.dart';
import 'package:filli/services/currentuser.dart';
import 'package:filli/services/googlesigninprovider.dart';
import 'package:filli/sidebar/sidebar_layout.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider<Currentuser>(
          create: (context) => Currentuser(),
        ),
      ],
      child: MaterialApp(
        title: 'filli',
        theme: ThemeData(
          backgroundColor: const Color(0xffffffff),
          scaffoldBackgroundColor: const Color(0xffffffff),
          hintColor: const Color(0xff9C9C9D),
          primaryColorLight: const Color(0xffF7F7F7),
          fontFamily: 'Kollektif',
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontFamily: 'Anteb',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/signup': (BuildContext context) => SignupPage(),
          '/profile': (BuildContext context) => ProfileScreen(),
          '/general': (BuildContext context) => GeneralScreen(),
          '/addlobby': (BuildContext context) => AddLobbyScreen(),
          '/createlobby': (BuildContext context) => CreateLobbyScreen(),
          '/project-overview': (BuildContext context) =>
              ProjectOverviewScreen(),
          '/todo': (BuildContext context) => TodoScreen(),
          '/notes': (BuildContext context) => NotesScreen(),
          '/links': (BuildContext context) => LinksScreen(),
          '/files': (BuildContext context) => FilesScreen(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.idTokenChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return SideBarLayout();
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}
