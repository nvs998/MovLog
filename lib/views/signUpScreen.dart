import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:movlog/views/homeScreen.dart';
import 'package:movlog/widgets/functions.dart';

import '../widgets/globals.dart' as glb;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isLoading = false;
  Future<void> signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      GoogleSignInAccount googleSignInAccount = await glb.googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      if (await FirebaseAuth.instance.signInWithCredential(credential) !=
          null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff000000),
                Color(0xff000428),
                Color(0xff000000),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/movLog.png",
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            SizedBox(
              height: 40,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : //ElevatedButton(
                //     style: ButtonStyle(),
                //     onPressed: signIn,
                //     child: Container(
                //       width: MediaQuery.of(context).size.width*0.7,
                //       child: Row(
                //         children: [
                //           Expanded(flex:2,child: Image.asset("images/google.png")),
                //           Expanded(child: SizedBox(width: 10,)),
                //           Expanded(
                //             flex: 6,
                //             child: Text(
                //               "SignIn with Google",
                //               style: textDesign(20),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   )
                SignInButtonBuilder(
                    text: 'Sign in with Google',
                    fontSize: 18,
                    onPressed: signIn,
                    backgroundColor: Colors.blueGrey[800],
                    image: Container(
                      //padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Image.asset('images/google.png'),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: MediaQuery.of(context).size.width * 0.6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
          ],
        ),
      ),
    );
  }
}
