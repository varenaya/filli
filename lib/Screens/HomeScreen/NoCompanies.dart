import 'package:flutter/material.dart';

class NoCompanies extends StatefulWidget {
  final size;
  final Map? userdata;
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
                fontFamily: 'Anteb',
                fontSize: 25,
                fontWeight: FontWeight.w700,
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
                text: ' ${widget.userdata!['email']}.',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Text(
          'You\'re all set to start a new Fiili lobby for your organisation.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
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
              fontFamily: 'Anteb',
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          endIndent: 20,
          indent: 20,
          color: Colors.black,
          thickness: 1,
        ),
        widget.userdata!['invitation'].isEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Couldn\'t find any lobby?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Well, we couldn\'t find any invitation either, ask a admin to send one, or try signing in with another account.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            : Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black45,
                        ),
                      ),
                      padding: EdgeInsets.only(left: 18, bottom: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.userdata!['invitation'][index]['company']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '${widget.userdata!['invitation'][index]['invitedby']} invited you')
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green.shade900,
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
                                  'Join',
                                  style: TextStyle(fontSize: 16),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: widget.userdata!['invitation'].length,
                ),
              ),
      ],
    );
  }
}
