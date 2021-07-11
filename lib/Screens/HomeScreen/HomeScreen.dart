import 'package:cloud_firestore/cloud_firestore.dart';
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
  final user = FirebaseAuth.instance.currentUser;
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit == true) {
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

    return StreamBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }

          final userdata = snapshot.data;
          return Scaffold(
            body: userdata!.data()!['companies'].isEmpty
                ? NoCompanies(
                    size: size,
                    userdata: userdata.data(),
                  )
                : DefaultHome(
                    size: size,
                  ),
          );
        });
  }
}
