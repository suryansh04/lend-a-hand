import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Forms extends StatelessWidget {
  final String input;
  final Widget inputIcon;
  final bool shownText;
  final TextInputType keyboard;
  final Function val;
  Forms(
      {@required this.input,
      @required this.inputIcon,
      @required this.shownText,
      @required this.keyboard,
      @required this.val});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: TextField(
        onChanged: val,
        obscureText: shownText,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: input,
          hintStyle: GoogleFonts.sourceSansPro(
            textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                letterSpacing: .5),
          ),
          prefixIcon: inputIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
