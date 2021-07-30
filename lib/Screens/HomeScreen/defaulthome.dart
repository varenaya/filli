import 'package:filli/Screens/ProjectOverviewScreen.dart';
import 'package:filli/services/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../ChannelScreen.dart';

class DefaultHome extends StatefulWidget {
  final size;
  final Map? userdata;
  const DefaultHome({Key? key, this.size, required this.userdata})
      : super(key: key);

  @override
  _DefaultHomeState createState() => _DefaultHomeState();
}

class _DefaultHomeState extends State<DefaultHome> {
  @override
  Widget build(BuildContext context) {
    var size = widget.size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.indigo],
            ),
          ),
          height: 108.0 + size.height * 0.06,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                'assets/images/Company_defimg.png',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${widget.userdata!['companies'].firstWhere((element) => element['selected'] == true, orElse: () => null)['name']}',
                          style: TextStyle(
                            fontFamily: 'Anteb',
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Channels',
                            style: TextStyle(
                              fontFamily: 'Anteb',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Divider(
                      height: 0,
                      color: Colors.black,
                      thickness: 1.5,
                      endIndent: 220,
                      indent: 30,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child: ChannelScreen(),
                          direction: AxisDirection.left,
                        ),
                      );
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 50, top: 8, bottom: 8),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.hashtag,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'general',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  childCount: 5,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Projects',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Anteb',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade900,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Divider(
                      height: 0,
                      color: Colors.black,
                      thickness: 1.5,
                      endIndent: 220,
                      indent: 30,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child: ProjectOverviewScreen(),
                          direction: AxisDirection.left,
                        ),
                      );
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 50, bottom: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Website Developement',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  childCount: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
