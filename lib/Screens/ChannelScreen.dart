import 'package:filli/widgets/chat_tile.dart';
import 'package:flutter/material.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
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
                          fontFamily: 'Anteb',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            constraints: const BoxConstraints(maxWidth: 35),
                            splashRadius: 25,
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                          IconButton(
                            constraints: const BoxConstraints(maxWidth: 35),
                            splashRadius: 25,
                            onPressed: () {},
                            icon: const Icon(Icons.call),
                          ),
                          IconButton(
                            constraints: const BoxConstraints(maxWidth: 35),
                            splashRadius: 25,
                            onPressed: () {},
                            icon: const Icon(Icons.info_outline),
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
