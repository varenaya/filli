import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filli/Screens/HomeScreen/NoCompanies.dart';
import 'package:filli/Screens/HomeScreen/defaulthome.dart';
import 'package:filli/models/userdata.dart';
import 'package:filli/services/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget with NavigationStates {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  DateTime timeBackPressed = DateTime.now();
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
        stream: _firestore.collection('users').doc(user!.uid).snapshots(),
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

          final userdatamap = snapshot.data;
          final UserData userdata = UserData(
              email: userdatamap!.data()!['email'],
              username: userdatamap.data()!['username'],
              userId: userdatamap.data()!['userId'],
              imageUrl: userdatamap.data()!['image_url'],
              coverUrl: userdatamap.data()!['cover_url'],
              online: userdatamap.data()!['online'],
              status: userdatamap.data()!['status'],
              companies: userdatamap.data()!['companies'],
              projects: userdatamap.data()!['projects'],
              invitation: userdatamap.data()!['invitation']);

          return WillPopScope(
            onWillPop: () async {
              final difference = DateTime.now().difference(timeBackPressed);
              final isExitWarning = difference >= Duration(seconds: 2);
              timeBackPressed = DateTime.now();
              if (isExitWarning) {
                final message = 'Press back again to exit';
                Fluttertoast.showToast(msg: message, fontSize: 18);
                return false;
              } else {
                Fluttertoast.cancel();
                return true;
              }
            },
            child: Scaffold(
              body: userdata.companies.isEmpty
                  ? NoCompanies(
                      size: size,
                      userdata: userdata,
                    )
                  : DefaultHome(
                      userdata: userdata,
                      size: size,
                    ),
            ),
          );
        });
  }
}
