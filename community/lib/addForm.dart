import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Addform extends StatelessWidget {
  final String input;
  final messageController;
  final Widget inputIcon;
  final Function val;
  Addform({
    @required this.input,
    @required this.inputIcon,
    @required this.val,
     @required this.messageController,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
style: TextStyle(
color: Colors.white,
),
        onChanged: val,
        controller: messageController,
        decoration: InputDecoration(
          hintText: input,
          
          hintStyle: GoogleFonts.sourceSansPro(
            textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                letterSpacing: .5),
                
          ),

          prefixIcon: inputIcon,
        
          border: OutlineInputBorder(
        borderSide:BorderSide(width:2,color:Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),

          ),
        )
        );
  }
}
