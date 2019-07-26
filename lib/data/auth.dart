import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mlibrary/mlibrary.dart';

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

  Pair<bool, String> verify(String email, String password) {
    try {
      final emailRegExp = RegExp(
          r"^[a-z0-9A-Z]+[a-zA-Z0-9_-]+[a-z0-9A-Z]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$");
      // 允许输入字母和数字
      // 不允许全是数字
      // 不允许全是字母
      // 密码长度必须在8-20位之间
      final passwordRegExp =
          RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z!@#$%^&*_-]{8,20}$");
      if (!emailRegExp.hasMatch(email)) return Pair(false, "请输入正确的邮箱地址");
      if (!passwordRegExp.hasMatch(password))
        return Pair(
            false, "请输入正确的密码，要求：允许输入字母和数字，不允许全是数字，不允许全是字母，密码长度必须在8-20位之间");
      return Pair(true, null);
    } catch (e) {
      return Pair(false, "验证失败");
    }
  }
}
