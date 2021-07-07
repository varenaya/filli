import 'package:filli/Auth/loginPage.dart';
import 'package:filli/pages/GeneralScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManagement {
  Widget handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          return GeneralScreen();
        }
        return LoginPage();
      },
    );
  }

  dynamic signOut() {
    FirebaseAuth.instance.signOut();
  }
}
