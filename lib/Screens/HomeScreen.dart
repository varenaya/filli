import 'package:filli/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:filli/services/currentuser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget with NavigationStates {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<Currentuser>(context).userdata();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 28,
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Text('Channels')
          ],
        ),
      ),
    );
  }
}
