import 'package:flutter/material.dart';

List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
];

class MyData {
  String _companyname = '';
  String _projectname = '';
}

class CreateLobbyScreen extends StatefulWidget {
  const CreateLobbyScreen({Key? key}) : super(key: key);

  @override
  _CreateLobbyScreenState createState() => _CreateLobbyScreenState();
}

class _CreateLobbyScreenState extends State<CreateLobbyScreen> {
  int currStep = 0;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static MyData data = MyData();
  var _isLoading = false;
  bool complete = false;
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
        await Future.delayed(Duration(seconds: 5)).then((value) {
          print('test');
          print('company: ${data._companyname}');
          print('project: ${data._projectname}');
        });
        setState(() {
          _isLoading = false;
        });
      } catch (err) {
        var message = 'An error occured, please check your credentials!';
        // if (err.message != null) {

        //   message = err.message!;
        // }
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
        child: Column(
          children: <Widget>[
            TextFormField(
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
          ],
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
        child: Column(
          children: <Widget>[
            TextFormField(
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
          ],
        ),
      ),
    ),
    Step(
      isActive: true,
      state: StepState.indexed,
      title: const Text(
        'Teammates',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'Anteb',
        ),
      ),
      subtitle: const Text(
        "Add your teammates for the project",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      content: Form(
        key: formKeys[2],
        child: Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo.shade900,
                elevation: 2,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Send Invites',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Anteb',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'or Skip for later',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
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
              height: 50,
            ),
            Container(
              height: size.height * 0.7,
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
                          fontSize: 18,
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
                                      _trySubmit().then((value) {
                                        currStep = 0;
                                        complete = true;
                                      });
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
