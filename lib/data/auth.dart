import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auths with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> login(String email, String password) async {
    final AuthCredential credential = EmailAuthProvider.getCredential(
      email: email,
      password: password,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    debugPrint("signed in " + user.displayName);
    return user;
  }

  Future<FirebaseUser> register(String email, String password) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }
}
