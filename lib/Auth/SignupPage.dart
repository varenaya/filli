import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userpassword = '';
  String _userName = '';
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    void _trySubmit() async {
      UserCredential authresult;
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();

      if (isValid) {
        _formKey.currentState!.save();
        try {
          setState(() {
            _isLoading = true;
          });
          authresult =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _userEmail,
            password: _userpassword,
          );
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authresult.user!.uid)
              .set({
            'username': _userName,
            'email': _userEmail,
            'image_url': '',
            'userId': authresult.user!.uid,
            'Companies': [],
            'status': '',
            'online': true,
          });
        } on FirebaseAuthException catch (err) {
          var message = 'An error occured, please check your credentials!';
          if (err.message != null) {
            message = err.message!;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message.toString(),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
          setState(() {
            _isLoading = false;
          });
        }
      }
      Navigator.of(context).pop();
    }

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: size.height * 0.07,
              bottom: size.height * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
              Hero(
                tag: 'welcome-image',
                child: Image(
                  width: size.width * 0.6,
                  image: AssetImage('assets/images/hwt_filli.png'),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        key: ValueKey('email'),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid Email address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Your Email"),
                        onSaved: (newValue) {
                          _userEmail = newValue!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        key: ValueKey('Username'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please enter atleast 4 characters.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Name"),
                        onSaved: (newValue) {
                          _userName = newValue!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        key: ValueKey('password'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return 'Password Must be 7 characters long';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Password"),
                        onSaved: (newValue) {
                          _userpassword = newValue!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: _trySubmit,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            elevation: 0,
                            padding: EdgeInsets.all(18),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
