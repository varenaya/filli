import 'dart:async';

import 'package:filli/Screens/AddLobbyScreen.dart';
import 'package:filli/Screens/SettingsScreen.dart';
import 'package:filli/models/userdata.dart';
import 'package:filli/services/custom_page_route.dart';
import 'package:filli/services/data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
  final _animationDuration = const Duration(milliseconds: 400);
  bool isHomeselected = true;
  bool isProfileselected = false;
  bool isDmselected = false;
  bool ismentionsselected = false;

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

    final userData = Provider.of<UserData>(context);
    Provider.of<DataProvider>(context).userData(userData);

    final selectedcompanydata = userData.companies.firstWhere(
        (element) => element['selected'] == true,
        orElse: () => null);
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
                              userData.companies.isEmpty
                                  ? CircleAvatar(
                                      foregroundImage: AssetImage(
                                          'assets/images/Astronaut.png'),
                                      radius: 45,
                                      backgroundColor: Colors.black54,
                                    )
                                  : selectedcompanydata['company_imgurl'] == ''
                                      ? CircleAvatar(
                                          foregroundImage: AssetImage(
                                            'assets/images/Company_defimg.png',
                                          ),
                                          radius: 45,
                                          backgroundColor: Colors.white,
                                        )
                                      : CircleAvatar(
                                          radius: 45,
                                          foregroundImage: NetworkImage(
                                            selectedcompanydata[
                                                'company_imgurl'],
                                          ),
                                        ),
                              SizedBox(
                                width: 15,
                              ),
                              userData.companies.isEmpty
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
                                      '${(userData.companies.firstWhere((element) => element['selected'] == true, orElse: () => null))['name']}',
                                      style: TextStyle(
                                        fontFamily: 'Anteb',
                                        fontSize: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                          userData.companies.isEmpty
                              ? SizedBox()
                              : IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      CustomPageRoute(
                                        child: SettingsScreen(),
                                        direction: AxisDirection.right,
                                      ),
                                    );
                                  },
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
                          setState(() {
                            isHomeselected = true;
                            isDmselected = false;
                            isProfileselected = false;
                            ismentionsselected = false;
                          });
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.HomeScreenClickedEvent);
                        },
                        child: isHomeselected
                            ? Container(
                                color: const Color(0xFF3935B7),
                                child: MenuItem(
                                  icon: Icons.home,
                                  title: "Home",
                                ),
                              )
                            : MenuItem(
                                icon: Icons.home,
                                title: "Home",
                              ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isHomeselected = false;
                            isDmselected = false;
                            isProfileselected = true;
                            ismentionsselected = false;
                          });
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ProfileScreenClickedEvent);
                        },
                        child: isProfileselected
                            ? Container(
                                color: const Color(0xFF3935B7),
                                child: MenuItem(
                                  icon: Icons.person,
                                  title: "You",
                                ),
                              )
                            : MenuItem(
                                icon: Icons.person,
                                title: "You",
                              ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isHomeselected = false;
                            isDmselected = true;
                            isProfileselected = false;
                            ismentionsselected = false;
                          });
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.DmScreenClickedEvent);
                        },
                        child: isDmselected
                            ? Container(
                                color: const Color(0xFF3935B7),
                                child: MenuItem(
                                  icon: Icons.chat_outlined,
                                  title: "Dms",
                                ),
                              )
                            : MenuItem(
                                icon: Icons.chat_outlined,
                                title: "Dms",
                              ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isHomeselected = false;
                            isDmselected = false;
                            isProfileselected = false;
                            ismentionsselected = true;
                          });
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.MentionsScreenClickedEvent);
                        },
                        child: ismentionsselected
                            ? Container(
                                color: const Color(0xFF3935B7),
                                child: MenuItem(
                                  icon: Icons.alternate_email_sharp,
                                  title: "Mentions",
                                ),
                              )
                            : MenuItem(
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
                          Navigator.of(context).push(
                            CustomPageRoute(
                              child: AddLobbyScreen(
                                userdata: userData,
                              ),
                              direction: AxisDirection.up,
                            ),
                          );
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
                      color: const Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: const Color(0xFF1BB5FD),
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
