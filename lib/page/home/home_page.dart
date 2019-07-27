import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:moon/component/theme.dart';
import 'package:moon/page/home/data_screen.dart';
import 'package:moon/page/home/moodview_screen.dart';
import 'package:moon/page/home/profile_screen.dart';
import 'package:moon/resource.dart';
import 'package:provider/provider.dart';
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
        // color: Colors.white,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        child: Consumer<AppTheme>(
          builder: (BuildContext context, AppTheme theme, Widget child) =>
              Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
                color: theme.accentColor,
              ),
            ),
            child: child,
          ),
          child: Stack(
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () => _jumpTo(0),
                  ),
                  IconButton(
                    icon: Icon(Icons.trip_origin),
                    onPressed: () => _jumpTo(1),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings_ethernet),
                    onPressed: () => _jumpTo(2),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              // Container(
              //   padding: EdgeInsets.only(top: 24),
              //   height: 48,
              //   child: SliderTheme(
              //     data: SliderTheme.of(context).copyWith(
              //       activeTrackColor: Colors.transparent,
              //       inactiveTrackColor: Colors.transparent,
              //       thumbColor: Theme.of(context).accentColor,
              //     ),
              //     child: Slider(
              //       onChanged: (double value) {},
              //       value: 0.5,
              //       // activeColor: Colors.transparent,
              //       // inactiveColor: Colors.transparent,
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(top: 24.0 + 8 + 4),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: <Widget>[
              //       Spacer(
              //         flex: 1,
              //       ),
              //       Container(
              //         height: 8,
              //         width: 8,
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: Theme.of(context).accentColor,
              //         ),
              //       ),
              //       Spacer(
              //         flex: 1,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          MoodViewScreen(),
          DataScreen(currentIndex: _index),
          ProfileScreen(),
        ],
      ),
    );
  }
}
