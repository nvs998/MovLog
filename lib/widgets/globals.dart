import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movlog/widgets/movie.dart';

List<Movie> films = [];

GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>["email"]);

void showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    new SnackBar(backgroundColor: Colors.grey[900],
     // padding: EdgeInsets.symmetric(v),
      elevation: 4,
      duration: Duration(seconds: 3),
      content: Text(text,style: TextStyle(fontSize:14),),
      shape: RoundedRectangleBorder(
          side: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}