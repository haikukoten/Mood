import 'package:flutter/material.dart';
import 'package:moon/app.route.dart';
import 'package:moon/data/mood.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoodCard extends StatelessWidget {
  final BuildContext parent;
  final int index;
  final Color color;
  final double parallaxOffset;

  MoodCard({Key key, this.parent, this.index, this.color, this.parallaxOffset}) : super(key: key);

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
            onTap: () => Navigator.of(context).pushNamed(ROUTE_CARD_PAGE, arguments: index),
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
                          child: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) =>
                                Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                // 视差效果
                                ..translate(-parallaxOffset * constraints.biggest.width * 0.3)
                                ..scale(1.4, 1.4, 0),
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          value.title,
                          style: TextStyle(fontSize: 24),
                        ),
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
