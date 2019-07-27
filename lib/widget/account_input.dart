import 'package:flutter/material.dart';

typedef AccountVerifyCallback = void Function(String, String);

class AccountInputWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isRegister;
  final AccountVerifyCallback onPressed;
  final bool isVerify;
  const AccountInputWidget({
    Key key,
    this.isRegister = false,
    this.onPressed,
    this.emailController,
    this.passwordController,
    this.isVerify = false,
  }) : super(key: key);

  @override
  _AccountInputWidgetState createState() => _AccountInputWidgetState();
}

class _AccountInputWidgetState extends State<AccountInputWidget> {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = widget.emailController ?? TextEditingController();
    passwordController = widget.passwordController ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Column(
          children: <Widget>[
            Spacer(),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "邮箱",
                // border: InputBorder.none,
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "密码",
                // border: InputBorder.none,
              ),
            ),
            Spacer(),
            Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: widget.isVerify
                    ? CircularProgressIndicator()
                    : FlatButton(
                        shape: StadiumBorder(),
                        onPressed: () => widget?.onPressed(
                            emailController.text, passwordController.text),
                        child: Text(widget.isRegister ? "注册" : "登录"),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
