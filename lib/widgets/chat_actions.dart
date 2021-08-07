import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:filli/services/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chatactions extends StatelessWidget {
  final Map chatdata;
  const Chatactions({Key? key, required this.chatdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<DataProvider>(context).userdata;
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    '😃',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    '👍',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    '😎',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    '🙂',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    '😂',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => EmojiPicker(
                      onEmojiSelected: (category, emoji) {},
                      config: Config(
                          columns: 7,
                          emojiSizeMax: 25.0,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          initCategory: Category.RECENT,
                          bgColor: Color(0xFFF2F2F2),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          progressIndicatorColor: Colors.blue,
                          showRecentsTab: true,
                          recentsLimit: 28,
                          noRecentsText: "No Recents",
                          noRecentsStyle: const TextStyle(
                              fontSize: 20, color: Colors.black26),
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (userdata.userId == chatdata['senderId'])
          ListTile(
            onTap: () {},
            leading: Icon(Icons.edit),
            title: Text('Edit Message'),
          ),
        ExpansionTile(
          leading: Icon(Icons.bookmark_border_rounded),
          title: Text('Add to ..'),
          children: [
            ExpansionTile(
              leading: Icon(
                Icons.rate_review_outlined,
              ),
              title: Text('Add to Todo'),
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Lobby',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('Personal',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.notes_outlined,
              ),
              title: Text('Add to Notes'),
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Lobby',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('Personal',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
            ExpansionTile(
              leading: Icon(
                Icons.link,
              ),
              title: Text('Add to Links'),
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Lobby',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('Personal',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.reply),
          title: Text('Reply in Tree'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.copy_sharp),
          title: Text('Copy Text'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.share),
          title: Text('Share Message'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.person_outline_sharp),
          title: Text('Profile'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.push_pin),
          title: Text('Pin to Channel'),
        ),
        if (userdata.userId == chatdata['senderId'])
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.delete_rounded,
              color: Colors.red,
            ),
            title: Text(
              'Delete Message',
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
