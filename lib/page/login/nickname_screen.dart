import 'package:flutter/material.dart';
import 'package:mlibrary/mlibrary.dart';

class NickNameScreen extends StatefulWidget {
  @override
  _NickNameScreenState createState() => _NickNameScreenState();
}

class _NickNameScreenState extends State<NickNameScreen> {
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 25.0 + 24 + 32 * 2 + 24,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              "情不知所起，一往而情深",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Theme(
              data: ThemeData.dark(),
              child: TextField(
                controller: _editingController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    helperText: "你的名字",
                    hintText: "告诉我们你的名字",
                    counterText: "${_editingController.text.length}/16"),
              ),
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
