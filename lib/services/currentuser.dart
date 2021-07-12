// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Currentuser extends ChangeNotifier {
  late Map<dynamic, dynamic> _userData;

  Map<dynamic, dynamic> get userData {
    return {..._userData};
  }

  userdata(Map? userinfo) {
    _userData = userinfo!;
  }

  // Future userdata(User? user) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user!.uid)
  //         .get()
  //         .then((value) {
  //       _userData = value.data()!;
  //     });
  //     notifyListeners();
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}
