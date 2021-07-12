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
    return Scaffold(
      body: Center(
        child: Text('Mentions'),
      ),
    );
  }
}
