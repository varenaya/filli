import 'package:filli/widgets/chat_tile.dart';
import 'package:flutter/material.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: size.height * 0.92,
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
                      Text(
                        '# general',
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
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 0,
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   'Description',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Text(
                  //   'Lorem IPsum Random description text of nothing just normal anything and random stuff going on with all the operations going.',
                  // ),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemBuilder: (context, index) => ChatTile(
                        size: size,
                      ),
                      itemCount: 5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 0.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Send Message',
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.image_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.link_sharp),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onPressed: () {}),
                        ),
                      ],
                    ),
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
