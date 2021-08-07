import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filli/services/data_provider.dart';
import 'package:filli/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChannelScreen extends StatefulWidget {
  final String channelname;
  final String comapnyid;
  final String projectid;

  const ChannelScreen(
      {Key? key,
      required this.channelname,
      required this.comapnyid,
      required this.projectid})
      : super(key: key);

  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  late final TextEditingController _textEditingController =
      TextEditingController();
  var _enteredMessage = '';
  final _firestore = FirebaseFirestore.instance;

  final _random = Random();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userdata = Provider.of<DataProvider>(context).userdata;
    void _secondMessage() async {
      FocusScope.of(context).unfocus();
      try {
        final DocumentReference docRef = widget.projectid == ''
            ? _firestore
                .collection('companies')
                .doc(widget.comapnyid)
                .collection(widget.channelname)
                .doc()
            : _firestore
                .collection('companies')
                .doc(widget.comapnyid)
                .collection('Projects')
                .doc(widget.projectid)
                .collection(widget.channelname)
                .doc();
        await docRef.set({
          'type': 'chat',
          'senderId': userdata.userId,
          'sendername': userdata.username,
          'senderimg': userdata.imageUrl,
          'messageid': docRef.id,
          'createdAt': DateTime.now(),
          'text': _enteredMessage,
          'colortile_int': _random.nextInt(Colors.primaries.length),
          'edited': false,
          'pinned': false,
          'reactions': [],
          'mentions': [],
          'saved': [],
          'replies': [],
        });
      } on FirebaseException catch (err) {
        print(err.message);
      }
      setState(() {
        _textEditingController.clear();
        _enteredMessage = '';
      });
    }

    return GestureDetector(
      onTap: () {
        return FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                          '# ${widget.channelname}',
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
                      child: widget.projectid == ''
                          ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: _firestore
                                  .collection('companies')
                                  .doc(widget.comapnyid)
                                  .collection(widget.channelname)
                                  .orderBy(
                                    'createdAt',
                                    descending: true,
                                  )
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                }
                                final chatdata = snapshot.data!.docs;
                                return chatdata.length == 1
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/no_activity.png'),
                                          ),
                                          Text(
                                            'No activity..',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Anteb'),
                                          )
                                        ],
                                      )
                                    : ListView.builder(
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        reverse: true,
                                        itemBuilder: (context, index) =>
                                            chatdata[index].data()['type'] ==
                                                    'chat'
                                                ? ChatTile(
                                                    chatdata:
                                                        chatdata[index].data(),
                                                    previouschatdata: index +
                                                                1 >
                                                            chatdata.length
                                                        ? {}
                                                        : chatdata[index + 1]
                                                            .data(),
                                                    size: size,
                                                  )
                                                : SizedBox(),
                                        itemCount: chatdata.length,
                                      );
                              })
                          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: _firestore
                                  .collection('companies')
                                  .doc(widget.comapnyid)
                                  .collection('Projects')
                                  .doc(widget.projectid)
                                  .collection(widget.channelname)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                }
                                final chatdata = snapshot.data!.docs;
                                return chatdata.length == 1
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/no_activity.png'),
                                          ),
                                          Text(
                                            'No activity..',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Anteb'),
                                          )
                                        ],
                                      )
                                    : ListView.builder(
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        reverse: true,
                                        itemBuilder: (context, index) =>
                                            chatdata[index].data()['type'] ==
                                                    'chat'
                                                ? ChatTile(
                                                    chatdata:
                                                        chatdata[index].data(),
                                                    previouschatdata: index +
                                                                1 >
                                                            chatdata.length
                                                        ? {}
                                                        : chatdata[index + 1]
                                                            .data(),
                                                    size: size,
                                                  )
                                                : SizedBox(),
                                        itemCount: chatdata.length,
                                      );
                              }),
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
                              minLines: 1,
                              maxLines: null,
                              focusNode: _focusNode,
                              controller: _textEditingController,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Send Message',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _enteredMessage = value;
                                });
                              },
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
                              onPressed:
                                  _enteredMessage == '' ? null : _secondMessage,
                            ),
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
      ),
    );
  }
}
