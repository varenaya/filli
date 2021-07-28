import 'package:filli/widgets/chat_tile.dart';
import 'package:flutter/material.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  // GlobalKey _key = LabeledGlobalKey("button_icon");
  // late OverlayEntry _overlayEntry;
  // late Size buttonSize;
  // late Offset buttonPosition;
  // bool isMenuOpen = false;

  // findButton() {
  //   RenderBox? renderBox =
  //       _key.currentContext!.findRenderObject() as RenderBox?;
  //   buttonSize = renderBox!.size;
  //   buttonPosition = renderBox.localToGlobal(Offset.zero);
  // }

  // OverlayEntry _overlayEntryBuilder() {
  //   return OverlayEntry(
  //     builder: (context) {
  //       return Positioned(
  //         top: buttonPosition.dy + buttonSize.height + 5,
  //         left: buttonPosition.dx - buttonSize.width * 8,
  //         width: buttonSize.width * 15,
  //         child: Material(
  //           elevation: 5,
  //           color: Color.fromRGBO(230, 230, 255, 1.0),
  //           child: Container(
  //             decoration: BoxDecoration(
  //               // border: Border.all(width: 5, color: Colors.white),
  //               // boxShadow: [
  //               //   BoxShadow(
  //               //     color: Colors.white,
  //               //     offset: Offset(0.0, 1.0), //(x,y)
  //               //     blurRadius: 6.0,
  //               //   ),
  //               // ],
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 10),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         'Description',
  //                         style: TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w600,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                       InkWell(
  //                         onTap: () {},
  //                         child: Icon(
  //                           Icons.edit,
  //                           size: 20,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Text(
  //                     'Lorem IPsum Random description text of nothing just normal anything and random stuff going on with all the operations going Icons are identified by their name as listed below.',
  //                     style: TextStyle(
  //                       fontSize: 15,
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.w300,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void openMenu() {
  //   findButton();
  //   _overlayEntry = _overlayEntryBuilder();
  //   Overlay.of(context)!.insert(_overlayEntry);
  //   isMenuOpen = !isMenuOpen;
  // }

  // void closeMenu() {
  //   _overlayEntry.remove();
  //   isMenuOpen = !isMenuOpen;
  // }

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
                          )),
                      Row(
                        children: [
                          Text(
                            '# general',
                            style: TextStyle(
                              fontFamily: 'Anteb',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            // key: _key,
                            onTap: () {
                              // setState(() {
                              //   if (isMenuOpen) {
                              //     closeMenu();
                              //   } else {
                              //     openMenu();
                              //   }
                              // });
                            },
                            child: Icon(
                              Icons.arrow_drop_down,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.call),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 0,
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   'Description',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Text(
                  //   'Lorem IPsum Random description text of nothing just normal anything and random stuff going on with all the operations going.',
                  // ),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemBuilder: (context, index) => ChatTile(
                        size: size,
                      ),
                      itemCount: 5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 0.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Send Message',
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.image_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.link_sharp),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onPressed: () {}),
                        ),
                      ],
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
