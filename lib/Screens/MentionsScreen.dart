import 'package:filli/services/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class MentionsScreen extends StatefulWidget with NavigationStates {
  const MentionsScreen({Key? key}) : super(key: key);

  @override
  _MentionsScreenState createState() => _MentionsScreenState();
}

class _MentionsScreenState extends State<MentionsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Container(
              height: size.height * 0.94,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Mentions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Anteb',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
