import 'package:filli/Screens/HomeScreen/NoCompanies.dart';
import 'package:filli/Screens/HomeScreen/defaulthome.dart';
import 'package:filli/services/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:filli/services/currentuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget with NavigationStates {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit == true) {
      final user = FirebaseAuth.instance.currentUser;
      Provider.of<Currentuser>(context).userdata(user);
    }
    setState(() {
      _isInit = false;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userdata = Provider.of<Currentuser>(context).userData;
    return Scaffold(
      body: userdata['companies'].isEmpty
          ? NoCompanies(
              size: size,
              userdata: userdata,
            )
          : DefaultHome(
              size: size,
            ),
    );
  }
}
