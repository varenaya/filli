import 'package:flutter/material.dart';

class Chatactions extends StatelessWidget {
  const Chatactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('delete'),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('delete'),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('delete'),
          ),
        ],
      ),
    );
  }
}
