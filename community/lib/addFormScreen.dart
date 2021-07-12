import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/addForm.dart';
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
String address;
final authInstance = FirebaseAuth.instance;
final textcontrolWork = TextEditingController();
final textcontrolTime = TextEditingController();
final textControlPrice = TextEditingController();
final textControlAddress = TextEditingController();
final fireStore = FirebaseFirestore.instance;

class AddFormScreen extends StatefulWidget {
  @override
  _AddFormScreenState createState() => _AddFormScreenState();
}

class _AddFormScreenState extends State<AddFormScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Text(
                            'Post request',
                            style: GoogleFonts.pacifico(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w600,
                              color:Colors.black,
                            ), 
                          ),
                                  ),
          Container(
           
            height: 630,
            decoration: BoxDecoration(
               color:Color(0xff4B43E6),
             borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(70.0)),
                                      
                                      // bottomLeft:Radius.circular(20.0),
            ),
            // width: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Column(
                children: [
               Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 80, 16.0, 0),
                    child: Container(
                      child: Column(children: [
                        Addform(
                          messageController: textcontrolWork,
                          input: 'Work to do',
                          inputIcon: Icon(Icons.work,color: Colors.white,),
                          val: (value) {
                            work = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Addform(
                          messageController: textcontrolTime,
                          input: 'Time',
                          inputIcon: Icon(Icons.schedule,color:Colors.white),
                          val: (value) {
                            time = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Addform(
                          messageController: textControlPrice,
                          input: 'Amount Giving',
                          inputIcon: Icon(Icons.euro,color: Colors.white,),
                          val: (value) {
                            price = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Addform(
                          messageController: textControlAddress,
                          input: 'Address',
                          inputIcon: Icon(Icons.place,color: Colors.white,),
                          val: (value) {
                            address = value;
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: GestureDetector(
                                onTap: () {
                                  textcontrolWork.clear();
                                  textControlPrice.clear();
                                  textcontrolTime.clear();
                                  textControlAddress.clear();
                                  userId = loggedUser.email;
                                  fireStore.collection('users').add({
                                    'work': work,
                                    'Time': time,
                                    'Fee': price,
                                    'id': userId,
                                    'address': address,
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    color: Color(0xff4785fe),
                                  ),
                                  width: 100.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.post_add,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Post',
                                            style: GoogleFonts.sourceSansPro(
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                )))
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
