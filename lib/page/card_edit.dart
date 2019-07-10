import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moon/app.route.dart';
import 'package:moon/data/mood.dart';
import 'package:moon/widget/mood_circle.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

@RoutePage(prarms: [RoutePrarm(name: "index", useNameAsKey: false)])
class CardEditPage extends StatefulWidget {
  final int index;

  const CardEditPage({Key key, this.index}) : super(key: key);

  @override
  _CardEditPageState createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {
  Color _backgroundColor = Colors.transparent;

  Future<String> openTextEditor() {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  "上传自",
                  style: Theme.of(context).textTheme.title.copyWith(fontSize: 17),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<MoodProvider>(context).documents[widget.index];
    final hasHeadImage = value.headImage != null && value.headImage.isNotEmpty;
    // final hasHeadImage = false;
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        // title: Text(value.title),
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
            Text(
              "修改时间：${value.updateTime}",
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
      body: Hero(
        tag: "home_card_${widget.index}",
        child: Card(
          elevation: 0,
          color: _backgroundColor,
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
                    child: GestureDetector(
                      child: CachedNetworkImage(
                        imageUrl: value.headImage,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                        fit: BoxFit.cover,
                      ),
                      onTap: () => Navigator.of(context).pushNamed(ROUTE_IMAGE_PREVIEW_PAGE,
                          arguments: {"imageUrl": value.headImage}),
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
                      // Container(
                      //   height: 24,
                      //   width: 24,
                      //   color: Colors.black,
                      // ),
                      MoodCircle(
                        color: Colors.blueAccent[100],
                        onPress: () {
                          setState(() {
                            _backgroundColor = Colors.blueAccent[100];
                          });
                        },
                      ),
                      MoodCircle(
                        color: Colors.blueAccent[200],
                        onPress: () {
                          setState(() {
                            _backgroundColor = Colors.blueAccent[200];
                          });
                        },
                      ),
                      MoodCircle(
                        color: Colors.blueAccent[400],
                        onPress: () {
                          setState(() {
                            _backgroundColor = Colors.blueAccent[400];
                          });
                        },
                      ),
                      MoodCircle(
                        color: Colors.blueAccent[700],
                        onPress: () {
                          setState(() {
                            _backgroundColor = Colors.blueAccent[700];
                          });
                        },
                      ),
                      MoodCircle(
                        color: Colors.blueAccent[700],
                        onPress: () {
                          setState(() {
                            _backgroundColor = Colors.blueAccent[700];
                          });
                        },
                      ),
                    ],
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
