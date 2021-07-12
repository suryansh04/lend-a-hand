import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/addForm.dart';
import 'package:community/addFormScreen.dart';
import 'package:community/form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

String userShown;
String work;
String time;
User loggedUser;
String userId;
String price;
final fireStore = FirebaseFirestore.instance;

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final authInstance = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = authInstance.currentUser;
    if (user != null) {
      loggedUser = user;
      userShown = await loggedUser.email;
      print(loggedUser.email);
    } else {
      print('uh - oh you are already logged in');
    }
  }

// ---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f4f9),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFormScreen()),
          );
        },
        child: const Icon(Icons.post_add),
        backgroundColor: Color(0xff4B43E6),
      ),
      body: SafeArea(
        child: Expanded(
          child: ListView(
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(22.0)),
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage('assets/checkf.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 200,
                        width: 500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Welcome to Lend a Hand ',
                            style: GoogleFonts.pacifico(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Posts',
                      style: GoogleFonts.pacifico(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: fireStore.collection('users').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final dataGet = snapshot.data.docs;
                            List<Widget> cards = [];
                            for (var info in dataGet) {
                              final posted = info.get('id');
                              final workData = info.get('work');
                              final feeData = info.get('Fee');
                              final timeData = info.get('Time');
                              final addressData = info.get('address');
                              final showWidgets = cardWidget(
                                providePosted: posted,
                                provideWork: workData,
                                provideFee: feeData,
                                provideTime: timeData,
                                provideAddress: addressData,
                              );
                              cards.add(showWidgets);
                            }
                            return Column(
                              children: cards,
                            );
                          }
                          return null;
                        }),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

//----------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------

class cardWidget extends StatelessWidget {
  final providePosted;
  final provideWork;
  final provideFee;
  final provideTime;
  final provideAddress;
  cardWidget({
    @required this.providePosted,
    @required this.provideWork,
    @required this.provideFee,
    @required this.provideTime,
       @required this.provideAddress,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          height: 280,
          width: 320,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(color: Color(0xff4b43e6), width: 3.0)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Posted By:',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        providePosted,
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          'Work to do:',
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          provideWork,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          'Time:',
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          provideTime,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          'Amount Giving:',
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          provideFee,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                           Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          'Address:',
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          provideAddress,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print('clicked on the button');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff4785fe),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text('Accept',
                                      style: GoogleFonts.sourceSansPro(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print('clicked on decline button');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15.0)),
                              color: Color(0xffE06f73),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text('Decline',
                                      style: GoogleFonts.sourceSansPro(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ])),
    );
  }
}
