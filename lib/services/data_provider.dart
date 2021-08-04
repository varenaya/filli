import 'package:filli/models/userdata.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  late UserData _userdata;

  UserData get userdata {
    return _userdata;
  }

  UserData userData(UserData userData) {
    return _userdata = userData;
  }
}
