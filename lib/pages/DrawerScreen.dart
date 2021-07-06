import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal.shade600,
      padding: EdgeInsets.only(top: 50, bottom: 20, left: 10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.amber,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Testoo',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.black,
            thickness: 1.5,
            endIndent: 250,
          ),
          SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/profile');
            },
            child: Row(
              children: [
                Icon(
                  Icons.account_box_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('You',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              print('text2');
            },
            child: Row(
              children: [
                Icon(
                  Icons.chat_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'DMs',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              print('text3');
            },
            child: Row(
              children: [
                Icon(
                  Icons.alternate_email_sharp,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Mentions',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Channels',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 35,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Divider(
            height: 0,
            color: Colors.black,
            thickness: 1.5,
            endIndent: 250,
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.hashtag,
                      size: 16,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'general',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: 10,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Projects',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 35,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Divider(
            height: 0,
            color: Colors.black,
            thickness: 1.5,
            endIndent: 250,
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Test',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
