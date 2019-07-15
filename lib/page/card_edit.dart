import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mlibrary/mlibrary.dart';
import 'package:moon/app.route.dart';
import 'package:moon/data/mood.dart';
import 'package:moon/util.dart';
import 'package:moon/widget/circle_container.dart';
import 'package:moon/widget/mood_circle.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:simple_animations/simple_animations.dart';

@RoutePage(prarms: [RoutePrarm(name: "index", useNameAsKey: false)])
class CardEditPage extends StatefulWidget {
  final int index;

  const CardEditPage({Key key, this.index}) : super(key: key);

  @override
  _CardEditPageState createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {
  Color _previousColor = Colors.white;
  Color _backgroundColor = Colors.white;
  double _maxRadius = 0.0;
  Offset _position;
  bool _useDarkTheme = false;

  final _keys = [
    GlobalKey(debugLabel: "index0"),
    GlobalKey(debugLabel: "index1"),
    GlobalKey(debugLabel: "index2"),
    GlobalKey(debugLabel: "index3"),
    GlobalKey(debugLabel: "index4"),
  ];
  final _colors = [
    // Colors.white,
    colorRGB(225, 225, 225),
    Colors.blueAccent[200],
    Colors.blue,
    Colors.blueAccent[400],
    Colors.blueAccent[700],
  ];
  final _useDarkThemes = [
    false,
    false,
    true,
    true,
    true,
  ];

  // 打开底部文本编辑框，
  // 目前存在TextField编辑时被键盘遮挡问题，确认为Flutter SDK BUG
  Future<String> openTextEditor(String value) async {
    final controller = TextEditingController(text: value);
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) =>
          // ListTile(
          //   title: TextField(
          //     controller: controller,
          //     decoration: InputDecoration(border: InputBorder.none),
          //     onSubmitted: (text) {
          //       Navigator.of(context).pop(text);
          //     },
          //   ),
          // ),
          BottomEditWidget(controller: controller),
    );
  }

  Offset _getViewPosition(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final offset = renderBox.localToGlobal(Offset.zero);
    return offset + Offset(28, 28);
  }

  void _changeMood(int index) {
    setState(() {
      _useDarkTheme = _useDarkThemes[index];
      _position = _getViewPosition(_keys[index]);
      _previousColor = _backgroundColor;
      _backgroundColor = _colors[index];
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maxRadius = max(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width) + 56;
  }

  @override
  Widget build(BuildContext context) {
    //build animation
    final tween = MultiTrackTween(
        [Track("radius").add(Duration(milliseconds: 400), Tween(begin: 0.0, end: _maxRadius))]);
    return ControlledAnimation(
      playback: Playback.START_OVER_FORWARD,
      duration: tween.duration,
      tween: tween,
      builderWithChild: (context, child, animation) => CircleContainer(
        color: _backgroundColor,
        backgroundColor: _previousColor,
        radius: run(() {
          final double radius = animation["radius"];
          if (radius >= _maxRadius - 1) {
            _previousColor = _backgroundColor;
          }
          return radius;
        }),
        position: _position,
        child: child,
      ),
      child: buildChild(context),
    );
  }

  Widget buildChild(BuildContext context) {
    final provider = Provider.of<MoodProvider>(context);
    final value = provider.documents[widget.index];
    final hasHeadImage = value.headImage != null && value.headImage.isNotEmpty;
    // final hasHeadImage = false;

    return Theme(
      data: _useDarkTheme ? ThemeData.dark() : Theme.of(context),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: GestureDetector(
            child: Text(value.title),
            onTap: () async {
              final text = await openTextEditor(value.title);
              if (text != null) provider.updateOrCreate(value..title = text);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.archive),
              onPressed: () {},
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(OMIcons.addBox), onPressed: () {}),
              Text("修改时间：${value.updateTime}"),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
        body: Hero(
          tag: "home_card_${widget.index}",
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(),
            margin: EdgeInsets.all(0.0),
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  if (hasHeadImage)
                    AspectRatio(
                      aspectRatio: 2 / 1,
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            child: SizedBox.expand(
                              child: CachedNetworkImage(
                                imageUrl: value.headImage,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Center(child: Icon(Icons.error)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () => Navigator.of(context).pushNamed(ROUTE_IMAGE_PREVIEW_PAGE,
                                arguments: {"imageUrl": value.headImage}),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: FlatButton.icon(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.zero,
                              color: colorRGB(98, 0, 238, 0.8),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24)),
                              ),
                              icon: Icon(Icons.photo_library),
                              label: Text("3"),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      value.title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        value.content,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // todo 用choiceChip包裹
                        MoodCircle(
                          key: _keys[0],
                          color: _colors[0],
                          onPress: () => _changeMood(0),
                        ),
                        MoodCircle(
                          key: _keys[1],
                          color: _colors[1],
                          onPress: () => _changeMood(1),
                        ),
                        MoodCircle(
                          key: _keys[2],
                          color: _colors[2],
                          onPress: () => _changeMood(2),
                        ),
                        MoodCircle(
                          key: _keys[3],
                          color: _colors[3],
                          onPress: () => _changeMood(3),
                        ),
                        MoodCircle(
                          key: _keys[4],
                          color: _colors[4],
                          onPress: () => _changeMood(4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomEditWidget extends StatefulWidget {
  final TextEditingController controller;
  BottomEditWidget({Key key, this.controller}) : super(key: key);

  _BottomEditWidgetState createState() => _BottomEditWidgetState();
}

class _BottomEditWidgetState extends State<BottomEditWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey[300],
            spreadRadius: 5,
          )
        ],
      ),
      child: DecoratedTextField(
        hintText: "在这里输入哦",
        controller: widget.controller,
      ),
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const DecoratedTextField({Key key, @required this.hintText, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hintText),
      ),
    );
  }
}
