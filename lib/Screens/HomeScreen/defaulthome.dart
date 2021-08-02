import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filli/Screens/ProjectOverviewScreen.dart';
import 'package:filli/services/custom_page_route.dart';
import 'package:filli/services/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    final selectedcompanydata = widget.userdata!['companies'].firstWhere(
        (element) => element['selected'] == true,
        orElse: () => null);
    return StreamBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('companies')
            .doc(selectedcompanydata['company_id'])
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
          final companyData = snapshot.data;
          // Future<void> changeimg() async {
          //   await Future.delayed(Duration(seconds: 2)).then((value) async {
          //     if (selectedcompanydata['company_imgurl'] !=
          //         companyData!.data()!['company_imgurl']) {
          //       await FirebaseFirestore.instance
          //           .collection('users')
          //           .doc(widget.userdata!['userId'])
          //           .update({
          //         'companies': FieldValue.arrayUnion([
          //           {
          //             'company_id': companyData.data()!['company_id'],
          //             'name': companyData.data()!['company_name'],
          //             'company_imgurl': companyData.data()!['company_imgurl'],
          //             'selected': true,
          //           }
          //         ]),
          //       });
          //       await FirebaseFirestore.instance
          //           .collection('users')
          //           .doc(widget.userdata!['userId'])
          //           .update({
          //         'companies': FieldValue.arrayRemove([
          //           {
          //             'company_id': companyData.data()!['company_id'],
          //             'name': companyData.data()!['company_name'],
          //             'company_imgurl': selectedcompanydata['company_imgurl'],
          //             'selected': true,
          //           }
          //         ]),
          //       });
          //     }
          //   });
          // }

          // changeimg();

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
                                    image: companyData!
                                                .data()!['company_imgurl'] ==
                                            ''
                                        ? AssetImage(
                                            'assets/images/Company_defimg.png',
                                          ) as ImageProvider
                                        : NetworkImage(companyData
                                            .data()!['company_imgurl']),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                companyData.data()!['company_name'],
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
                            padding: const EdgeInsets.only(
                                left: 50, top: 8, bottom: 8),
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
                                  companyData.data()!['channels'][i],
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        childCount: companyData.data()!['channels'].length,
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
                        (ctx, i) => widget.userdata!['projects'].firstWhere(
                                    (element) =>
                                        element['project_id'] ==
                                        companyData.data()!['projects'][i]
                                            ['project_id'],
                                    orElse: () => null) !=
                                null
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    CustomPageRoute(
                                      child: ProjectOverviewScreen(),
                                      direction: AxisDirection.left,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 50, bottom: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        companyData.data()!['projects'][i]
                                            ['project_name'],
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                        childCount: companyData.data()!['projects'].length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
