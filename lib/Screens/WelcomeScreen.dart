import 'package:filli/services/googlesigninprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final authprovider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                authprovider.googlesignin.disconnect();
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false));
              },
              icon: Icon(
                Icons.logout_sharp,
              ))
        ],
      ),
      body: Container(),
    );
  }
}
