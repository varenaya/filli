import 'package:flutter/material.dart';

class CreateLobbyScreen extends StatefulWidget {
  const CreateLobbyScreen({Key? key}) : super(key: key);

  @override
  _CreateLobbyScreenState createState() => _CreateLobbyScreenState();
}

class _CreateLobbyScreenState extends State<CreateLobbyScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
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
                          color: Colors.black,
                        )),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
