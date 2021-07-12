import 'package:community/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String passwords;
    String emails;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            SvgPicture.asset(
              "assets/signup.svg",
              height: 250.0,
              width: 400.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Sign Up',
              style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600,
                fontSize: 30.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Forms(
              input: 'Enter your email',
              inputIcon: Icon(Icons.email),
              shownText: false,
              keyboard: TextInputType.emailAddress,
              val: (value) {
                emails = value;
              },
            ),
            Forms(
              input: 'Enter your passoword',
              inputIcon: Icon(Icons.lock),
              shownText: true,
              keyboard: TextInputType.text,
              val: (value) {
                passwords = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () async {
               
                try {
                  final newUser = await auth.createUserWithEmailAndPassword(
                      email: emails, password: passwords);
                      if(newUser != null){
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => homeScreen()),
                );
                  }
                } catch (e) {
                  print('Registration Error');
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
                      horizontal: 35.0, vertical: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Create Account',
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
            ),
          ],
        ),
      ),
    );
  }
}
