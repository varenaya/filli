import 'package:filli/pages/DrawerScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;
  bool isactive = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor)
              ..rotateY(isDrawerOpen ? -0.5 : 0),
            decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 20,
              //     offset: Offset(0, 10),
              //     color: Colors.teal.shade200,
              //   )
              // ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: size.height,
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(isDrawerOpen ? 40 : 0.0)),
                            color: Colors.red,
                          ),
                          height: size.height * 0.2,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  isDrawerOpen
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              xOffset = 0;
                                              yOffset = 0;
                                              scaleFactor = 1;
                                              isDrawerOpen = false;
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.notes_outlined,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              xOffset = size.width * 0.48;
                                              yOffset = size.height * 0.12;
                                              scaleFactor = 0.8;
                                              isDrawerOpen = true;
                                            });
                                          }),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance
                                              .signOut()
                                              .then((value) => Navigator.of(
                                                      context)
                                                  .pushNamedAndRemoveUntil(
                                                      '/',
                                                      (Route<dynamic> route) =>
                                                          false));
                                        },
                                        icon: Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.22,
                            ),
                            InkWell(
                              splashColor: Colors.grey.shade200,
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                ),
                                width: size.width * 0.8,
                                height: size.height * 0.06,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.emoji_emotions_outlined,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Set your Custom status',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            InkWell(
                              splashColor: Colors.grey.shade200,
                              onTap: () {
                                setState(() {
                                  isactive = !isactive;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.remember_me_outlined,
                                      color: Colors.grey.shade700,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      isactive
                                          ? 'Set as Away'
                                          : 'Set as Online',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 0,
                              color: Colors.black,
                              thickness: 1,
                              endIndent: 5,
                              indent: 5,
                            ),
                            InkWell(
                              splashColor: Colors.grey.shade200,
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.notifications,
                                      color: Colors.grey.shade700,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Notifications',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.grey.shade200,
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.rate_review_outlined,
                                      color: Colors.grey.shade700,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ToDo',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Personal',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.grey.shade200,
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.notes_outlined,
                                      color: Colors.grey.shade700,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Notes',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Personal',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.grey.shade200,
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.link,
                                      color: Colors.grey.shade700,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Links',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Personal',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.17,
                            ),
                            Text(
                              'beta v1.0',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: size.width * 0.1,
                          top: size.height * 0.17,
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.blue,
                          ),
                        ),
                        Positioned(
                          left: size.width * 0.38,
                          top: size.height * 0.21,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jemini Tore',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    isactive ? 'Online' : 'Away',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.online_prediction_sharp,
                                    color: isactive ? Colors.green : Colors.red,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
