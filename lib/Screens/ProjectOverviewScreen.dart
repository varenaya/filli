import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filli/Screens/FilesScreen.dart';
import 'package:filli/Screens/ChannelScreen.dart';
import 'package:filli/Screens/LinksScreen.dart';
import 'package:filli/Screens/NotesScreen.dart';
import 'package:filli/Screens/TodoScreen.dart';
import 'package:filli/services/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectOverviewScreen extends StatefulWidget {
  final String projectId;
  final String companyId;
  const ProjectOverviewScreen(
      {Key? key, required this.projectId, required this.companyId})
      : super(key: key);

  @override
  _ProjectOverviewScreenState createState() => _ProjectOverviewScreenState();
}

class _ProjectOverviewScreenState extends State<ProjectOverviewScreen> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: size.height * 0.06,
        ),
        Container(
          height: size.height * 0.94,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder<DocumentSnapshot<Map<dynamic, dynamic>>>(
              stream: _firestore
                  .collection('companies')
                  .doc(widget.companyId)
                  .collection('Projects')
                  .doc(widget.projectId)
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

                final projectdata = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close_rounded,
                            )),
                        Expanded(
                          child: Text(
                            projectdata!.data()!['project_name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Anteb',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.info_outline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      height: 0,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      'Project Overview',
                      style: TextStyle(
                        fontFamily: 'Anteb',
                        fontSize: 17,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      projectdata.data()!['description'],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.lightBlue.shade100,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Timeline',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Anteb',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            width: double.infinity,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              CustomPageRoute(
                                child: TodoScreen(),
                                direction: AxisDirection.left,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/icons/todo_logo.png'),
                                  height: 60,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'ToDo',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              CustomPageRoute(
                                child: NotesScreen(),
                                direction: AxisDirection.left,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/icons/notes_logo.png'),
                                  height: 60,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              CustomPageRoute(
                                child: LinksScreen(),
                                direction: AxisDirection.left,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/icons/links_logo.png'),
                                  height: 60,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Links',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              CustomPageRoute(
                                child: FilesScreen(),
                                direction: AxisDirection.left,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/icons/files_logo.png'),
                                  height: 60,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Files',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Channels',
                              style: TextStyle(
                                fontFamily: 'Anteb',
                                fontSize: 17,
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
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Divider(
                          height: 0,
                          color: Colors.black,
                          thickness: 1.5,
                          endIndent: size.width * 0.6,
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              CustomPageRoute(
                                child: ChannelScreen(
                                  comapnyid: widget.companyId,
                                  projectid: widget.projectId,
                                  channelname: projectdata.data()!['channels']
                                      [index],
                                ),
                                direction: AxisDirection.left,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 8, bottom: 8),
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
                                  projectdata.data()!['channels'][index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        itemCount: projectdata.data()!['channels'].length,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    ));
  }
}
