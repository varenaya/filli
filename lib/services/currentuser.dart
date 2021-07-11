import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Currentuser extends ChangeNotifier {
  late Map<String, dynamic> _userData;

  Map<String, dynamic> get userData {
    return {..._userData};
  }

  Future userdata(User? user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((value) {
        _userData = value.data()!;
      });
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }
}
