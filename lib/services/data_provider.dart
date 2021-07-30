import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  late Map<dynamic, dynamic> _userData;

  Map<dynamic, dynamic> get userData {
    return {..._userData};
  }

  userdata(Map? userinfo) {
    _userData = userinfo!;
  }
}
