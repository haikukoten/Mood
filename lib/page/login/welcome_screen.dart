import 'package:flutter/material.dart';
import 'package:moon/component/theme.dart';
import 'package:moon/page/login/login_page.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25.0 + 24 + 48 * 2 + 24 * 2,
          ),
          Text(
            "欢迎你",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "我是Mood",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "你是这儿一位新的小伙伴哦",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Spacer(),
          SizedBox(
            width: 140,
            child: RaisedButton(
              color: Colors.white,
              elevation: 8,
              highlightElevation: 4,
              shape: StadiumBorder(),
              onPressed: () {
                LoginPage.loginPageKey.currentState.animatedTo(1);
              },
              child: Consumer<AppTheme>(
                builder: (context, theme, child) => Text(
                  "Hi Mood",
                  style: TextStyle(
                    color: theme.accentColor,
                  ),
                ),
              ),
            ),
          ),
          FlatButton(
            child: Text("我已拥有账号"),
            shape: StadiumBorder(),
            onPressed: () {},
          ),
          SizedBox(
            height: 96,
          ),
        ],
      ),
    );
  }
}
