import 'package:flutter/material.dart';

class NoCompanies extends StatefulWidget {
  final size;
  final Map userdata;
  const NoCompanies({Key? key, this.size, required this.userdata})
      : super(key: key);

  @override
  _NoCompaniesState createState() => _NoCompaniesState();
}

class _NoCompaniesState extends State<NoCompanies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.size.height * 0.1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Let\'s get Started !',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        Image(
          height: widget.size.height * 0.4,
          image: AssetImage('assets/images/welcome.png'),
        ),
        SizedBox(
          height: widget.size.height * 0.01,
        ),
        RichText(
          text: TextSpan(
            text: 'You\'ve logged in as',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                  text: ' ${widget.userdata['email']}.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        Text(
          'You\'re all set to start a new Fiili lobby for your organisation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: widget.size.height * 0.05,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Colors.indigo.shade900,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'Create a new Lobby',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Divider(
          endIndent: 20,
          indent: 20,
          color: Colors.black,
          thickness: 1,
          height: 40,
        ),
        widget.userdata['invitation'].isEmpty
            ? Column(
                children: [
                  Text(
                    'Couldn\'t find any lobby?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Well, we couldn\'t find any invitation, ask a admin to send one, Or try signing with another account.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            : Card(
                child: Text('ghg'),
              ),
      ],
    );
  }
}
