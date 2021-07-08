import 'package:filli/Screens/DrawerScreen.dart';
import 'package:filli/services/currentuser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  void didChangeDependencies() {
    Provider.of<Currentuser>(context, listen: false).userdata();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor)
              ..rotateY(isDrawerOpen ? -0.5 : 0),
            decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 20,
              //     offset: Offset(0, 10),
              //     color: Colors.teal.shade200,
              //   )
              // ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: size.height,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isDrawerOpen
                                ? IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      setState(() {
                                        xOffset = 0;
                                        yOffset = 0;
                                        scaleFactor = 1;
                                        isDrawerOpen = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.notes_outlined,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        xOffset = size.width * 0.48;
                                        yOffset = size.height * 0.12;
                                        scaleFactor = 0.8;
                                        isDrawerOpen = true;
                                      });
                                    }),
                            Text(
                              '#general',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
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
                                  icon: Icon(Icons.call),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
