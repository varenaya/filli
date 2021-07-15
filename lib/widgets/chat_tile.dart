import 'dart:math';

import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final size;

  const ChatTile({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _random = Random();

    return InkWell(
      onLongPress: () {
        print('object');
      },
      child: Stack(
        children: [
          Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                leading: CircleAvatar(),
                title: Text(
                  'Jemini Tore',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'July 15',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '4:15 PM',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: size.width * 0.8,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    width: 4,
                                    color: Colors.primaries[_random
                                        .nextInt(Colors.primaries.length)],
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.only(left: 5),
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'In general, we can make random colors ourselves with only a few lines of code so there’s no need to using a third-party plugin. However, using plugins also has a few advantages. For example, a package name random_color generates random colors that are visually pleasing and',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontFamily: 'Kollektif',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' (edited)',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black45,
                                        fontFamily: 'Kollektif',
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ],
      ),
    );
  }
}
