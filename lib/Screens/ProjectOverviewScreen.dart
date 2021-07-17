import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectOverviewScreen extends StatefulWidget {
  const ProjectOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProjectOverviewScreenState createState() => _ProjectOverviewScreenState();
}

class _ProjectOverviewScreenState extends State<ProjectOverviewScreen> {
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
          child: Column(
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
                      'Website Developement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Anteb',
                        fontSize: 18,
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
                'Its a random test project for developement and to get random overview some lorem ipsum type things. To do this we have to get more text and write random stuff with no sense at all.',
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
                    Row(
                      children: [Text('Started on: 15 July 2021, 5:20 PM')],
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 10,
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.rate_review_outlined,
                              color: Colors.grey.shade700,
                              size: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'ToDo',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 10,
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.notes_outlined,
                              color: Colors.grey.shade700,
                              size: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Notes',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 10,
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.link,
                              color: Colors.grey.shade700,
                              size: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Links',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 10,
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.file_copy,
                              color: Colors.grey.shade700,
                              size: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Files',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: Colors.blueGrey,
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
                      Navigator.of(context).pushNamed('/general');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 8, bottom: 8),
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
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
