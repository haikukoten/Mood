import 'package:flutter/material.dart';
import 'package:moon/page/home/data_screen.dart';
import 'package:moon/page/home/moodview_screen.dart';
import 'package:moon/page/home/profile_screen.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _index = 0;

  void _jumpTo(int index) {
    if (index != _index) {
      setState(() => _index = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () => _jumpTo(0)),
            IconButton(icon: Icon(Icons.trip_origin), onPressed: () => _jumpTo(1)),
            IconButton(icon: Icon(Icons.settings_ethernet), onPressed: () => _jumpTo(2)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          MoodViewScreen(),
          DataScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
