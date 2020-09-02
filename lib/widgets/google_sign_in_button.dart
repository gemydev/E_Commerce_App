import 'package:E_commerce/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



final _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Widget signInButton() {
  return Builder(
    builder: (context) => OutlineButton(
      onPressed: () async {
        onGoogleSignIn(context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/icons/google_logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}


void onGoogleSignIn(BuildContext context) async {
  FirebaseUser user = await _handleSignIn();
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
}

Future<FirebaseUser> _handleSignIn() async {
  FirebaseUser user;
  bool isSignedIn = await googleSignIn.isSignedIn();
  if (isSignedIn) {
    user = await _auth.currentUser();
  }
  else {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );
    user = (await _auth.signInWithCredential(credential)).user;
  }
  return user;
}

Future<void> sendEmailVerification() async {
  FirebaseUser user = await _auth.currentUser();
  user.sendEmailVerification();
}

Future<bool> isEmailVerified() async {
  FirebaseUser user = await _auth.currentUser();
  return user.isEmailVerified;
}

