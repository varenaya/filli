import 'package:flutter/material.dart';

class AddLobbyScreen extends StatefulWidget {
  const AddLobbyScreen({Key? key}) : super(key: key);

  @override
  _AddLobbyScreenState createState() => _AddLobbyScreenState();
}

class _AddLobbyScreenState extends State<AddLobbyScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userdata =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    List companies = userdata['companies'];
    List invitations = userdata['invitation'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: size.height,
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
                            return InkWell(
                              onTap: () async {
                                // await FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(user!.uid)
                                //     .update({
                                //   'companies': FieldValue.delete(),
                                // }).then((value) async {
                                //   await FirebaseFirestore.instance
                                //       .collection('users')
                                //       .doc(user!.uid)
                                //       .update({
                                //         'companies': FieldValue.arrayUnion([userdata.data()!['companies'][index+1],])
                                //       });
                                // });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
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
                                          image: companies[index]['i_url'] == ''
                                              ? AssetImage(
                                                      'assets/images/Company_defimg.png')
                                                  as ImageProvider
                                              : NetworkImage(
                                                  companies[index]['i_url'],
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
                                                color: Colors.green.shade900),
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
                          itemCount: userdata['invitation'].length,
                        ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/createlobby');
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
