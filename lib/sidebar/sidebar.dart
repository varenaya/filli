import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';

import 'package:filli/services/bloc.navigation_bloc/navigation_bloc.dart';

import '../sidebar/menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  final user = FirebaseAuth.instance.currentUser;
  final _animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
        List companies = userdata!.data()!['companies'];
        return StreamBuilder<bool>(
          initialData: false,
          stream: isSidebarOpenedStream,
          builder: (context, isSideBarOpenedAsync) {
            return AnimatedPositioned(
              duration: _animationDuration,
              top: 0,
              bottom: 0,
              left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
              right: isSideBarOpenedAsync.data! ? 0 : screenWidth - 45,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: const Color(0xFF262AAA),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  companies.isEmpty
                                      ? CircleAvatar(
                                          foregroundImage: AssetImage(
                                              'assets/images/Astronaut.png'),
                                          radius: 45,
                                          backgroundColor: Colors.black54,
                                        )
                                      : (companies.firstWhere(
                                                  (element) =>
                                                      element['selected'] ==
                                                      true,
                                                  orElse: () =>
                                                      null))['i_url'] ==
                                              ''
                                          ? CircleAvatar(
                                              foregroundImage: AssetImage(
                                                'assets/images/Company_defimg.png',
                                              ),
                                              radius: 45,
                                              backgroundColor: Colors.white,
                                            )
                                          : CircleAvatar(
                                              radius: 45,
                                              backgroundColor: Colors.black,
                                            ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  companies.isEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Hey,',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'You have\'nt joined a Lobby yet!',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          '${(companies.firstWhere((element) => element['selected'] == true, orElse: () => null))['name']}',
                                          style: TextStyle(
                                            fontFamily: 'Anteb',
                                            fontSize: 28,
                                            color: Colors.white,
                                          ),
                                        ),
                                ],
                              ),
                              companies.isEmpty
                                  ? SizedBox()
                                  : IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                            ],
                          ),
                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: Colors.black,
                            indent: 32,
                            endIndent: 32,
                          ),
                          InkWell(
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(context)
                                  .add(NavigationEvents.HomeScreenClickedEvent);
                            },
                            child: MenuItem(
                              icon: Icons.home,
                              title: "Home",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(context).add(
                                  NavigationEvents.ProfileScreenClickedEvent);
                            },
                            child: MenuItem(
                              icon: Icons.person,
                              title: "You",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(context)
                                  .add(NavigationEvents.DmScreenClickedEvent);
                            },
                            child: MenuItem(
                              icon: Icons.chat_outlined,
                              title: "Dms",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              onIconPressed();
                              BlocProvider.of<NavigationBloc>(context).add(
                                  NavigationEvents.MentionsScreenClickedEvent);
                            },
                            child: MenuItem(
                              icon: Icons.alternate_email_sharp,
                              title: "Mentions",
                            ),
                          ),
                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: Colors.black,
                            indent: 32,
                            endIndent: 32,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/addlobby',
                                  arguments: userdata.data());
                            },
                            child: MenuItem(
                              icon: Icons.add_circle_outline_sharp,
                              title: "Add a Filli lobby",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -0.9),
                    child: GestureDetector(
                      onTap: () {
                        onIconPressed();
                      },
                      child: ClipPath(
                        clipper: CustomMenuClipper(),
                        child: Container(
                          width: 35,
                          height: 110,
                          color: Color(0xFF262AAA),
                          alignment: Alignment.centerLeft,
                          child: AnimatedIcon(
                            progress: _animationController.view,
                            icon: AnimatedIcons.menu_close,
                            color: Color(0xFF1BB5FD),
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
