import 'package:flutter/material.dart';
import 'package:moon/app.route.dart';
import 'package:moon/data/mood.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoodCard extends StatelessWidget {
  final BuildContext parent;
  final int index;
  final Color color;

  MoodCard({Key key, this.parent, this.index, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<MoodProvider>(context, listen: false).documents[index];
    const radius = Radius.circular(8.0);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(ROUTE_CARD_EDIT_PAGE, arguments: index),
            child: Hero(
              tag: "home_card_$index",
              child: Card(
                // color: color,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(radius),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 2 / 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
                          child: CachedNetworkImage(
                            imageUrl: value.headImage,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        value.title,
                        style: TextStyle(fontSize: 24),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          value.content,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
