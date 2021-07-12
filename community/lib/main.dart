import 'package:community/home.dart';
import 'package:community/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
 dynamic emails;
  dynamic passwords;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/login.svg",
              height: 250.0,
              width: 400.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    onChanged: (value) {
                      emails = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: GoogleFonts.sourceSansPro(
                        textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontWeight: FontWeight.w400),
                      ),
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: TextField(
                    onChanged: (value) {
                      passwords = value;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: GoogleFonts.sourceSansPro(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            letterSpacing: .5),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      final user = await auth.signInWithEmailAndPassword(
                          email: emails, password: passwords);
                      if (user != null) {
                        print('User is now logged in');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => homeScreen()),
                        );
                      }
                    } catch (e) {
                      print('User is not logged in');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff4B43E6),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 42.0, vertical: 20.0),
                      child: Text(
                        'Login',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.8),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 200.0,
                  child: Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      color: Colors.black,
                    )),
                    Text(
                      'Or',
                      style: GoogleFonts.sourceSansPro(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.black,
                    )),
                  ]),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff4B43E6),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 20.0),
                      child: Text(
                        'Signup',
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.8),
                        ),
                      ),
                    ),
                  ),
                ),

        
              ],
            ),
          ],
        ),
      ),
    );
  }
}
