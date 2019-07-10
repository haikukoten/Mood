import 'package:flutter/material.dart';
import 'package:moon/app.route.dart';
import 'package:moon/data/mood.dart';
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
      providers: [ChangeNotifierProvider.value(value: MoodProvider())],
      child: MaterialApp(
        initialRoute: "/",
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          accentColor: Colors.cyan[600],
        ),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
