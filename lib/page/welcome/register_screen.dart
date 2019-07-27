import 'package:flutter/material.dart';
import 'package:moon/app.route.dart';
import 'package:moon/component/theme.dart';
import 'package:moon/widget/account_input.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25.0 + 24 + 32 * 2 + 24,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                "情不知所起，一往而情深",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Spacer(),
          Expanded(
            child: Consumer<AppTheme>(
              builder: (context, theme, child) => Theme(
                data:
                    Theme.of(context).copyWith(accentColor: theme.accentColor),
                child: AccountInputWidget(
                  isRegister: true,
                  onPressed: (email, password) {
                    // Scaffold.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text("请输入正确的信息"),
                    //   ),
                    // );
                    Navigator.pushNamed(context, ROUTE_HOME_PAGE);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
