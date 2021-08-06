import 'package:filli/widgets/chat_actions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatTile extends StatelessWidget {
  final size;
  final Map chatdata;
  final Map previouschatdata;

  const ChatTile(
      {Key? key,
      this.size,
      required this.chatdata,
      required this.previouschatdata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (previouschatdata != {} &&
            previouschatdata['senderId'] == chatdata['senderId'])
          (chatdata['createdAt'].toDate())
                      .difference(previouschatdata['createdAt'].toDate())
                      .inMinutes <
                  1
              ? Column(
                  children: [
                    InkWell(
                      onLongPress: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          context: context,
                          builder: (context) => Chatactions(
                            chatdata: chatdata,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 56,
                        ),
                        child: Container(
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        width: 4,
                                        color: Colors.primaries[
                                            chatdata['colortile_int']],
                                      ),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(left: 5),
                                  child: RichText(
                                    text: TextSpan(
                                      text: chatdata['text'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontFamily: 'Kollektif',
                                      ),
                                      children: [
                                        TextSpan(
                                          text: chatdata['edited']
                                              ? ' (edited)'
                                              : '',
                                          style: const TextStyle(
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
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )
              : ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${DateFormat.yMMMd().format(chatdata['createdAt'].toDate())}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${DateFormat.jm().format(chatdata['createdAt'].toDate())}',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onLongPress: () {
                          FocusScope.of(context).unfocus();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            context: context,
                            builder: (context) => Chatactions(
                              chatdata: chatdata,
                            ),
                          );
                        },
                        child: Container(
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        width: 4,
                                        color: Colors.primaries[
                                            chatdata['colortile_int']],
                                      ),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(left: 5),
                                  child: RichText(
                                    text: TextSpan(
                                      text: chatdata['text'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontFamily: 'Kollektif',
                                      ),
                                      children: [
                                        TextSpan(
                                          text: chatdata['edited']
                                              ? ' (edited)'
                                              : '',
                                          style: const TextStyle(
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
                      ),
                    ],
                  ),
                )
        else
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.white24,
                  backgroundImage: chatdata['senderimg'] == ""
                      ? AssetImage('assets/images/Person.png') as ImageProvider
                      : NetworkImage(
                          chatdata['senderimg'],
                        ),
                ),
                title: Text(
                  chatdata['sendername'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${DateFormat.yMMMd().format(chatdata['createdAt'].toDate())}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${DateFormat.jm().format(chatdata['createdAt'].toDate())}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onLongPress: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          context: context,
                          builder: (context) => Chatactions(
                            chatdata: chatdata,
                          ),
                        );
                      },
                      child: Container(
                        width: size.width * 0.8,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      width: 4,
                                      color: Colors
                                          .primaries[chatdata['colortile_int']],
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(left: 5),
                                child: RichText(
                                  text: TextSpan(
                                    text: chatdata['text'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontFamily: 'Kollektif',
                                    ),
                                    children: [
                                      TextSpan(
                                        text: chatdata['edited']
                                            ? ' (edited)'
                                            : '',
                                        style: const TextStyle(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
