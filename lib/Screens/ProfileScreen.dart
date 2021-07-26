import 'package:filli/Screens/LinksScreen.dart';
import 'package:filli/Screens/NotesScreen.dart';
import 'package:filli/Screens/TodScreen.dart';
import 'package:filli/services/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:filli/services/currentuser.dart';
import 'package:filli/services/custom_page_route.dart';

import 'package:filli/services/googlesigninprovider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget with NavigationStates {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isactive = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userData = Provider.of<Currentuser>(context, listen: false).userData;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.redAccent.shade100,
                  height: size.height * 0.2,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                              final authprovider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              authprovider.googlesignin.disconnect();
                              await FirebaseAuth.instance.signOut().then(
                                  (value) => Navigator.of(context)
                                      .pushNamedAndRemoveUntil('/',
                                          (Route<dynamic> route) => false));
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                            RichText(
                              text: TextSpan(
                                  text: 'Set as ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: isactive ? 'Away' : 'Online',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ]),
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
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.grey.shade200,
                      onTap: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: TodoScreen(),
                            direction: AxisDirection.left,
                          ),
                        );
                      },
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ToDo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
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
                      onTap: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: NotesScreen(),
                            direction: AxisDirection.left,
                          ),
                        );
                      },
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
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
                      onTap: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: LinksScreen(),
                            direction: AxisDirection.left,
                          ),
                        );
                      },
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Links',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: userData['image_url'] == ""
                            ? AssetImage('assets/images/Person.png')
                                as ImageProvider
                            : NetworkImage(
                                userData['image_url'],
                              ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: size.width * 0.38,
                  top: size.height * 0.21,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData['username'],
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
