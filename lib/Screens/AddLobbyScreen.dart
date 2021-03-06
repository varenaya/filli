import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filli/Screens/CreateLobbyScreen.dart';
import 'package:filli/models/userdata.dart';
import 'package:filli/services/custom_page_route.dart';
import 'package:flutter/material.dart';

class AddLobbyScreen extends StatefulWidget {
  final UserData userdata;
  const AddLobbyScreen({Key? key, required this.userdata}) : super(key: key);

  @override
  _AddLobbyScreenState createState() => _AddLobbyScreenState();
}

class _AddLobbyScreenState extends State<AddLobbyScreen> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    List companies = widget.userdata.companies;
    List invitations = widget.userdata.invitation;

    return Scaffold(
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
                            color: Colors.black,
                          )),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Logged in lobbies',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Switch lobbies by tapping on them',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  companies.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Text(
                                'No lobbies here!',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.scaleDown,
                                image: AssetImage('assets/images/nothing.png'),
                              )),
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return companies[index]['selected'] == true
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.lightBlue.shade100,
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.only(bottom: 5, top: 5),
                                      child: ListTile(
                                        leading: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: companies[index]
                                                          ['company_imgurl'] ==
                                                      ""
                                                  ? AssetImage(
                                                          'assets/images/Company_defimg.png')
                                                      as ImageProvider
                                                  : NetworkImage(
                                                      companies[index]
                                                          ['company_imgurl'],
                                                    ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          '${companies[index]['name']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade900),
                                        ),
                                        trailing: companies[index]['selected']
                                            ? Text(
                                                'Selected',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.green.shade900),
                                              )
                                            : SizedBox(),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      final selectedcompanydata =
                                          companies.firstWhere(
                                              (element) =>
                                                  element['selected'] == true,
                                              orElse: () => null);
                                      await _firestore
                                          .collection('users')
                                          .doc(widget.userdata.userId)
                                          .update({
                                        'companies': FieldValue.arrayUnion([
                                          {
                                            'name': companies[index]['name'],
                                            'company_id': companies[index]
                                                ['company_id'],
                                            'company_imgurl': companies[index]
                                                ['company_imgurl'],
                                            'selected': true,
                                          },
                                          {
                                            'name': selectedcompanydata['name'],
                                            'company_id': selectedcompanydata[
                                                'company_id'],
                                            'company_imgurl':
                                                selectedcompanydata[
                                                    'company_imgurl'],
                                            'selected': false,
                                          }
                                        ]),
                                      }).then((value) async {
                                        await _firestore
                                            .collection('users')
                                            .doc(widget.userdata.userId)
                                            .update({
                                          'companies': FieldValue.arrayRemove([
                                            companies[index],
                                            selectedcompanydata
                                          ]),
                                        });
                                      }).then((value) =>
                                              Navigator.of(context).pop());
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.lightBlue.shade100,
                                          ),
                                        ),
                                        padding:
                                            EdgeInsets.only(bottom: 5, top: 5),
                                        child: ListTile(
                                          leading: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: companies[index][
                                                            'company_imgurl'] ==
                                                        ""
                                                    ? AssetImage(
                                                            'assets/images/Company_defimg.png')
                                                        as ImageProvider
                                                    : NetworkImage(
                                                        companies[index]
                                                            ['company_imgurl'],
                                                      ),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            '${companies[index]['name']}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade900),
                                          ),
                                          trailing: companies[index]['selected']
                                              ? Text(
                                                  'Selected',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .green.shade900),
                                                )
                                              : SizedBox(),
                                        ),
                                      ),
                                    ),
                                  );
                          },
                          itemCount: companies.length,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Invitations',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  invitations.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Text(
                                'No Invitations!',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.scaleDown,
                                image:
                                    AssetImage('assets/images/no_invite.png'),
                              )),
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
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
                                      image: invitations[index]['img_url'] == ""
                                          ? AssetImage(
                                                  'assets/images/Company_defimg.png')
                                              as ImageProvider
                                          : NetworkImage(
                                              invitations[index]['img_url'],
                                            ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  '${invitations[index]['company']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  '${invitations[index]['invitedby']} invited you',
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final _firesbase =
                                          FirebaseFirestore.instance;
                                      final selectedcompanydata =
                                          widget.userdata.companies.firstWhere(
                                              (element) =>
                                                  element['selected'] == true,
                                              orElse: () => null);

                                      await _firestore
                                          .collection('users')
                                          .doc(widget.userdata.userId)
                                          .update({
                                        'companies': FieldValue.arrayRemove(
                                            [selectedcompanydata]),
                                      }).then((value) async {
                                        await _firestore
                                            .collection('users')
                                            .doc(widget.userdata.userId)
                                            .update({
                                          'companies': FieldValue.arrayUnion([
                                            {
                                              'name': invitations[index]
                                                  ['company'],
                                              'company_id': invitations[index]
                                                  ['company_id'],
                                              'selected': true,
                                              'company_imgurl':
                                                  invitations[index]['img_url'],
                                            },
                                            {
                                              'name':
                                                  selectedcompanydata['name'],
                                              'company_id': selectedcompanydata[
                                                  'company_id'],
                                              'company_imgurl':
                                                  selectedcompanydata[
                                                      'company_imgurl'],
                                              'selected': false,
                                            }
                                          ]),
                                          'invitation': FieldValue.arrayRemove(
                                              [invitations[index]]),
                                          'projects': FieldValue.arrayUnion([
                                            {
                                              'company_id': widget.userdata
                                                      .invitation[index]
                                                  ['company_id'],
                                              'project_id': widget.userdata
                                                      .invitation[index]
                                                  ['project_id'],
                                            }
                                          ]),
                                        });
                                      }).then((value) async {
                                        await _firesbase
                                            .collection('companies')
                                            .doc(widget
                                                    .userdata.invitation[index]
                                                ['company_id'])
                                            .collection('members')
                                            .where('email',
                                                isEqualTo:
                                                    widget.userdata.email)
                                            .get()
                                            .then((value) {
                                          _firesbase
                                            ..collection('companies')
                                                .doc(widget.userdata
                                                        .invitation[index]
                                                    ['company_id'])
                                                .collection('members')
                                                .doc(value.docs.first.id)
                                                .update({
                                              'inv_accepted': true,
                                              'userId': widget.userdata.userId,
                                              'username':
                                                  widget.userdata.username,
                                            });
                                        });
                                        await _firesbase
                                            .collection('companies')
                                            .doc(widget
                                                    .userdata.invitation[index]
                                                ['company_id'])
                                            .collection('Projects')
                                            .doc(
                                              widget.userdata.invitation[index]
                                                  ['project_id'],
                                            )
                                            .collection('members')
                                            .where('email',
                                                isEqualTo:
                                                    widget.userdata.email)
                                            .get()
                                            .then((value) {
                                          _firesbase
                                            ..collection('companies')
                                                .doc(widget.userdata
                                                        .invitation[index]
                                                    ['company_id'])
                                                .collection('Projects')
                                                .doc(
                                                  widget.userdata
                                                          .invitation[index]
                                                      ['project_id'],
                                                )
                                                .collection('members')
                                                .doc(value.docs.first.id)
                                                .update({
                                              'inv_accepted': true,
                                              'userId': widget.userdata.userId,
                                              'username':
                                                  widget.userdata.username,
                                            });
                                        });
                                        Navigator.of(context).pop();
                                      });
                                    },
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
                          itemCount: invitations.length,
                        ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: CreateLobbyScreen(
                              userdata: widget.userdata,
                            ),
                            direction: AxisDirection.up,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_sharp,
                            size: 30,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Text(
                            'Create new Lobby',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
