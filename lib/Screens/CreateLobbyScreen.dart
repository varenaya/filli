import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:filli/models/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
];

class MyData {
  String _companyname = '';
  String _projectname = '';
  List<String> emails = [];
}

class CreateLobbyScreen extends StatefulWidget {
  final UserData userdata;
  const CreateLobbyScreen({Key? key, required this.userdata}) : super(key: key);

  @override
  _CreateLobbyScreenState createState() => _CreateLobbyScreenState();
}

class _CreateLobbyScreenState extends State<CreateLobbyScreen> {
  int currStep = 0;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static MyData data = MyData();
  var _isLoading = false;
  bool emailskipped = false;
  bool complete = false;
  late TextEditingController _emailController;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      formKeys[0].currentState!.save();
      formKeys[1].currentState!.save();
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });
        final DocumentReference docRef =
            _firestore.collection('companies').doc();
        await docRef.set({
          'company_name': data._companyname.trim(),
          'company_imgurl': '',
          'company_id': docRef.id,
          'createdAt': DateTime.now(),
          'createrid': widget.userdata.userId,
          'members_count': data.emails.length + 1,
          'channels': ['general', 'casual'],
          'projects': [],
        });
        if (data.emails.isNotEmpty) {
          await _firestore
              .collection('companies')
              .doc(docRef.id)
              .collection('members')
              .add({
            'emails': widget.userdata.email,
            'role': 'creater',
            'inv_accepted': true,
            'username': widget.userdata.username,
            'userId': widget.userdata.username,
          });
          data.emails.forEach((element) async {
            await _firestore
                .collection('companies')
                .doc(docRef.id)
                .collection('members')
                .add({
              'emails': element,
              'role': 'member',
              'inv_accepted': false,
            });
          });
        } else {
          await _firestore
              .collection('companies')
              .doc(docRef.id)
              .collection('members')
              .add({
            'emails': widget.userdata.email,
            'role': 'creater',
            'inv_accepted': true,
            'username': widget.userdata.username,
            'userId': widget.userdata.userId,
          });
        }

        final DocumentReference projectdocRef = _firestore
            .collection('companies')
            .doc(docRef.id)
            .collection('Projects')
            .doc();
        await projectdocRef.set({
          'project_name': data._projectname,
          'project_id': projectdocRef.id,
          'description':
              'This description defines the purpose of the project, objectives for other projects members so thta they can get hold of the things they are dealing with. This can be edited later.',
          'channels': ['general', 'casual'],
          'members_count': data.emails.length + 1,
          'createdAt': DateTime.now(),
          'createrid': widget.userdata.userId,
        });
        await _firestore.collection('companies').doc(docRef.id).update({
          'projects': FieldValue.arrayUnion([
            {
              'project_name': data._projectname,
              'project_id': projectdocRef.id,
            }
          ])
        });

        final selectedcompanydata = widget.userdata.companies.firstWhere(
            (element) => element['selected'] == true,
            orElse: () => null);

        if (selectedcompanydata != null) {
          await _firestore
              .collection('users')
              .doc(widget.userdata.userId)
              .update({
            'companies': FieldValue.arrayUnion([
              {
                'name': data._companyname,
                'company_id': docRef.id,
                'company_imgurl': '',
                'selected': true,
              },
              {
                'name': selectedcompanydata['name'],
                'company_id': selectedcompanydata['company_id'],
                'company_imgurl': selectedcompanydata['company_imgurl'],
                'selected': false,
              }
            ]),
            'projects': FieldValue.arrayUnion([
              {
                'project_id': projectdocRef.id,
                'company_id': docRef.id,
              }
            ])
          });
          await _firestore
              .collection('users')
              .doc(widget.userdata.userId)
              .update({
            'companies': FieldValue.arrayRemove([
              {
                'name': selectedcompanydata['name'],
                'company_id': selectedcompanydata['company_id'],
                'company_imgurl': selectedcompanydata['company_imgurl'],
                'selected': true,
              }
            ]),
          });
        } else {
          await _firestore
              .collection('users')
              .doc(widget.userdata.userId)
              .update({
            'companies': FieldValue.arrayUnion([
              {
                'name': data._companyname,
                'company_id': docRef.id,
                'company_imgurl': '',
                'selected': true,
              },
            ]),
            'projects': FieldValue.arrayUnion([
              {
                'project_id': projectdocRef.id,
                'company_id': docRef.id,
              }
            ])
          });
        }

        await _firestore
            .collection('companies')
            .doc(docRef.id)
            .collection('general')
            .add({
          'type': 'Channel_data',
          'channel_name': 'general',
          'description':
              'This channel is the main channel of the lobby, which includes all teammates. It can be used for team-wide communication and announcements',
          'members_count': data.emails.length + 1,
          'createdAt': DateTime.now(),
          'createdby': widget.userdata.username,
          'createrid': widget.userdata.userId,
        });
        await _firestore
            .collection('companies')
            .doc(docRef.id)
            .collection('casual')
            .add({
          'type': 'Channel_data',
          'channel_name': 'casual',
          'description':
              'This is a fun channel, to enjoy with your teammates. Share memes, GIFs or anything to loose up some stress!',
          'members_count': data.emails.length + 1,
          'createdAt': DateTime.now(),
          'createdby': widget.userdata.username,
          'createrid': widget.userdata.userId,
        });
        await _firestore
            .collection('companies')
            .doc(docRef.id)
            .collection('Projects')
            .doc(projectdocRef.id)
            .collection('general')
            .add({
          'type': 'Channel_data',
          'channel_name': 'general',
          'description':
              'This channel is the main channel of the project, which includes all project members. It can be used for project-wide communication and announcements',
          'members_count': data.emails.length + 1,
          'createdAt': DateTime.now(),
          'createdby': widget.userdata.username,
          'createrid': widget.userdata.userId,
        });
        await _firestore
            .collection('companies')
            .doc(docRef.id)
            .collection('Projects')
            .doc(projectdocRef.id)
            .collection('casual')
            .add({
          'type': 'Channel_data',
          'channel_name': 'casual',
          'description':
              'This is a fun channel, to enjoy with your project teammates. Share memes, GIFs or anything to loose up some stress!',
          'members_count': data.emails.length + 1,
          'createdAt': DateTime.now(),
          'createdby': widget.userdata.username,
          'createrid': widget.userdata.userId,
        });
        if (data.emails.isNotEmpty) {
          await _firestore
              .collection('companies')
              .doc(docRef.id)
              .collection('Projects')
              .doc(projectdocRef.id)
              .collection('members')
              .add({
            'emails': widget.userdata.email,
            'role': 'creater',
            'inv_accepted': true,
            'username': widget.userdata.username,
            'userId': widget.userdata.userId,
          });
          data.emails.forEach((element) async {
            await _firestore
                .collection('companies')
                .doc(docRef.id)
                .collection('Projects')
                .doc(projectdocRef.id)
                .collection('members')
                .add({
              'emails': element,
              'role': 'member',
              'inv_accepted': false,
            });
            await _firestore
                .collection('users')
                .where('email', isEqualTo: element)
                .get()
                .then((value) {
              if (value.docs.isNotEmpty) {
                _firestore
                    .collection('users')
                    .doc(value.docs.first.data()['userId'])
                    .update({
                  'invitation': FieldValue.arrayUnion([
                    {
                      'img_url': '',
                      'company': data._companyname,
                      'company_id': docRef.id,
                      'invitedby': widget.userdata.username,
                    }
                  ]),
                });
              }
            });
          });
        } else {
          await _firestore
              .collection('companies')
              .doc(docRef.id)
              .collection('Projects')
              .doc(projectdocRef.id)
              .collection('members')
              .add({
            'emails': widget.userdata.email,
            'role': 'creater',
            'inv_accepted': true,
            'username': widget.userdata.username,
            'userId': widget.userdata.userId,
          });
        }
        setState(() {
          _isLoading = false;
        });
      } on FirebaseException catch (err) {
        var message = 'An error occured, please check your credentials!';
        if (err.message != null) {
          message = err.message!;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message.toString(),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }
  }

  List<Step> steps = [
    Step(
      title: const Text(
        'Company',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'Anteb',
        ),
      ),
      subtitle: const Text(
        'What\'s name of your Comapny or Team?',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      isActive: true,
      state: StepState.indexed,
      content: Form(
        key: formKeys[0],
        child: TextFormField(
          key: ValueKey('company name'),
          keyboardType: TextInputType.text,
          autocorrect: false,
          onSaved: (value) {
            data._companyname = value!;
          },
          validator: (value) {
            if (value!.isEmpty || value.length < 2) {
              return 'Please enter a name';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Organization Name'),
        ),
      ),
    ),
    Step(
      isActive: true,
      state: StepState.indexed,
      title: const Text(
        'Project',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'Anteb',
        ),
      ),
      subtitle: const Text(
        'What\'s the project you are currently working on?',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      content: Form(
        key: formKeys[1],
        child: TextFormField(
          key: ValueKey('project name'),
          keyboardType: TextInputType.text,
          autocorrect: false,
          onSaved: (value) {
            data._projectname = value!;
          },
          validator: (value) {
            if (value!.isEmpty || value.length < 2) {
              return 'Please enter a project name';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Project Name'),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Container(
              height: size.height * 0.6,
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
                      Text(
                        'Create your lobby here',
                        style: TextStyle(
                          fontFamily: 'Anteb',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                  complete
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Your Lobby has been created!',
                              style: TextStyle(
                                fontFamily: 'Anteb',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              height: size.height * 0.4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                // fit: BoxFit.scaleDown,
                                image:
                                    AssetImage('assets/images/add_lobby.png'),
                              )),
                            ),
                            Text(
                              'Skadoosh, Now you can easily connect with your team and get your project done in no time...',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        )
                      : Expanded(
                          child: Form(
                            key: _formKey,
                            child: Stepper(
                              steps: steps,
                              type: StepperType.vertical,
                              currentStep: this.currStep,
                              controlsBuilder: (context,
                                  {onStepCancel, onStepContinue}) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    _isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.lightBlue,
                                          )
                                        : Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: onStepContinue,
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      Colors.green.shade900,
                                                  elevation: 0,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 22,
                                                    vertical: 10,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Continue',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              TextButton(
                                                onPressed: onStepCancel,
                                                child: Text(
                                                  'CANCEL',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                );
                              },
                              onStepContinue: () {
                                setState(() {
                                  if (formKeys[currStep]
                                      .currentState!
                                      .validate()) {
                                    if (currStep < steps.length - 1) {
                                      currStep = currStep + 1;
                                    } else {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (context, setModalState) {
                                            return SingleChildScrollView(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 5,
                                                        left: 30,
                                                      ),
                                                      child: ListTile(
                                                        minLeadingWidth: 10,
                                                        leading: CircleAvatar(
                                                          radius: 12,
                                                          child: Text(
                                                            '3',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              Colors.blue,
                                                        ),
                                                        title: Text(
                                                          'Teammates',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily: 'Anteb',
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          'Add your teammates for the project',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        Container(
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                ...data.emails
                                                                    .map(
                                                                      (email) =>
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              15,
                                                                        ),
                                                                        child: Chip(
                                                                            avatar: CircleAvatar(
                                                                              backgroundColor: Colors.grey,
                                                                              child: Text(
                                                                                email.substring(0, 1),
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                            ),
                                                                            labelPadding: EdgeInsets.only(
                                                                              left: 10,
                                                                              right: 5,
                                                                            ),
                                                                            label: Text(
                                                                              email,
                                                                              style: TextStyle(fontSize: 16, color: Colors.black),
                                                                            ),
                                                                            onDeleted: () {
                                                                              setModalState(() {
                                                                                data.emails.removeWhere((element) => email == element);
                                                                              });
                                                                            }),
                                                                      ),
                                                                    )
                                                                    .toList(),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 30,
                                                            right: 30,
                                                            bottom: 15,
                                                            top: 5,
                                                          ),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            decoration:
                                                                InputDecoration
                                                                    .collapsed(
                                                              hintText:
                                                                  'Enter emails of your teammates',
                                                            ),
                                                            controller:
                                                                _emailController,
                                                            onChanged:
                                                                (String val) {
                                                              if (val.endsWith(
                                                                      ' ') &&
                                                                  EmailValidator
                                                                      .validate(
                                                                          val.trim()))
                                                                setModalState(
                                                                    () {
                                                                  data.emails.add(
                                                                      _emailController
                                                                          .text
                                                                          .trim());
                                                                  _emailController
                                                                      .text = '';
                                                                });
                                                            },
                                                            onEditingComplete:
                                                                () {
                                                              setModalState(() {
                                                                if (EmailValidator
                                                                    .validate(
                                                                        _emailController
                                                                            .text
                                                                            .trim())) {
                                                                  data.emails.add(
                                                                      _emailController
                                                                          .text
                                                                          .trim());
                                                                  _emailController
                                                                      .text = '';
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              if (EmailValidator
                                                                  .validate(
                                                                      _emailController
                                                                          .text
                                                                          .trim())) {
                                                                data.emails.add(
                                                                    _emailController
                                                                        .text
                                                                        .trim());
                                                              }
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              data.emails
                                                                      .isEmpty
                                                                  ? showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (ctx) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            'Are you sure?',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                          content:
                                                                              Text(
                                                                            'Do you want to continue without adding teammates?',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                          actions: <
                                                                              Widget>[
                                                                            TextButton(
                                                                              child: const Text('CANCEL'),
                                                                              onPressed: () {
                                                                                Navigator.of(ctx).pop();
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              child: const Text('CONTINUE'),
                                                                              onPressed: () {
                                                                                Navigator.of(ctx).pop();
                                                                                _trySubmit().then((value) {
                                                                                  complete = true;
                                                                                  data.emails = [];
                                                                                });
                                                                              },
                                                                            )
                                                                          ],
                                                                        );
                                                                      })
                                                                  : _trySubmit()
                                                                      .then(
                                                                          (value) {
                                                                      complete =
                                                                          true;
                                                                      data.emails =
                                                                          [];
                                                                    });
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Colors
                                                                  .green
                                                                  .shade900,
                                                              elevation: 0,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 22,
                                                                vertical: 10,
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Continue',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
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
                                          });
                                        },
                                      );
                                      currStep = 0;
                                    }
                                  }
                                });
                              },
                              onStepCancel: () {
                                setState(() {
                                  if (currStep > 0) {
                                    currStep = currStep - 1;
                                  } else {
                                    currStep = 0;
                                  }
                                });
                              },
                              onStepTapped: (step) {
                                setState(() {
                                  currStep = step;
                                });
                              },
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
