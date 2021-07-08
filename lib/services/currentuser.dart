import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Currentuser extends ChangeNotifier {
  final _user = FirebaseAuth.instance.currentUser;
  bool incompany = true;
  late Map<String, dynamic> _userData;

  User? get user => _user;
  Map<String, dynamic> get userData {
    return {..._userData};
  }

  Future userdata() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .get()
        .then((value) {
      _userData = value.data()!;
    });
    notifyListeners();
  }
}
