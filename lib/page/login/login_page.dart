import 'package:flutter/material.dart';
import 'package:moon/app.route.dart';
import 'package:moon/component/theme.dart';
import 'package:moon/widget/account_input.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppTheme>(
        builder: (context, theme, child) => Theme(
          data: ThemeData.dark().copyWith(accentColor: theme.accentColor),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: theme.currentColors,
              ),
            ),
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
                      data: Theme.of(context)
                          .copyWith(accentColor: theme.accentColor),
                      child: AccountInputWidget(
                        onPressed: (email, password) {
                          Navigator.pushNamed(context, ROUTE_HOME_PAGE);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
