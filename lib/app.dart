import 'package:flutter/material.dart';
import 'package:moon/app.route.dart';
import 'package:moon/component/theme.dart';
import 'package:moon/data/auth.dart';
import 'package:moon/data/mood.dart';
import 'package:moon/data/storage.dart';
import 'package:moon/vision/vision_util.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

@Router()
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MoodProvider()),
        ChangeNotifierProvider.value(value: Auths()),
        ChangeNotifierProvider.value(value: Vision()),
        ChangeNotifierProvider.value(value: StorageProvider()),
        ChangeNotifierProvider.value(value: AppTheme()),
      ],
      child: Consumer<AppTheme>(
        builder: (BuildContext context, value, Widget child) => MaterialApp(
          initialRoute: "/",
          // initialRoute: ROUTE_HOME_PAGE,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
            accentColor: Colors.cyan[600],
          ),
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}
