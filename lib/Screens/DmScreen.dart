import 'package:filli/services/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class DmScreen extends StatefulWidget with NavigationStates {
  const DmScreen({Key? key}) : super(key: key);

  @override
  _DmScreenState createState() => _DmScreenState();
}

class _DmScreenState extends State<DmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('DMS'),
      ),
    );
  }
}
