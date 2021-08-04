import 'package:filli/models/userdata.dart';
import 'package:filli/services/custom_page_route.dart';
import 'package:flutter/material.dart';

import '../CreateLobbyScreen.dart';

class NoCompanies extends StatefulWidget {
  final size;
  final UserData userdata;
  const NoCompanies({Key? key, this.size, required this.userdata})
      : super(key: key);

  @override
  _NoCompaniesState createState() => _NoCompaniesState();
}

class _NoCompaniesState extends State<NoCompanies> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: ' ${widget.userdata.email}.',
                  style: TextStyle(
                    fontSize: 16,
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
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRoute(
                  child: CreateLobbyScreen(userdata: widget.userdata),
                  direction: AxisDirection.left,
                ),
              );
            },
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
            height: 1,
            thickness: 1,
          ),
          widget.userdata.invitation.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Couldn\'t find any lobby?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.lightBlue.shade100,
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: widget.userdata.invitation[index]
                                          ['img_url'] ==
                                      ""
                                  ? AssetImage(
                                          'assets/images/Company_defimg.png')
                                      as ImageProvider
                                  : NetworkImage(
                                      widget.userdata.invitation[index]
                                          ['img_url'],
                                    ),
                            ),
                          ),
                        ),
                        title: Text(
                          '${widget.userdata.invitation[index]['company']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '${widget.userdata.invitation[index]['invitedby']} invited you',
                        ),
                        trailing: Padding(
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: widget.userdata.invitation.length,
                ),
        ],
      ),
    );
  }
}
