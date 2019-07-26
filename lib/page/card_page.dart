import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moon/data/mood.dart';
import 'package:moon/util.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

final debugTags = [
  "",
  "红色",
  "蓝色",
  "建筑物",
  "科幻",
  "玻璃",
  "水滴",
  "砂砾",
  "海洋",
  "礁石",
  "生活",
  "",
];

@RoutePage(prarms: [RoutePrarm(name: "index", useNameAsKey: false)])
class CardPage extends StatelessWidget {
  final int index;
  const CardPage({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setTranslateStatusBar();
    final provider = Provider.of<MoodProvider>(context);
    final value = provider.documents[index];
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top, //展开高度200
            // leading: Container(),
            automaticallyImplyLeading: false,
            // iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
            // brightness: ThemeData.dark().brightness,
            pinned: false,
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: Hero(
              tag: "home_card_$index",
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        value.headImage,
                      ),
                      fit: BoxFit.cover),
                  color: Colors.white,
                ),
              ),
            ),
            // flexibleSpace: FlexibleSpaceBar(
            //   background: CachedNetworkImage(
            //     imageUrl: value.headImage,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            bottom: PreferredSize(
              preferredSize: Size(0, 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, bottom: 8.0),
                    child: Text(
                      DateFormat('M-dd').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, bottom: 12.0),
                    child: Text(
                      value.title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Padding(
                    // left: 24.0, right: 24.0,
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      height: 28,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: debugTags.length,
                        itemBuilder: (BuildContext context, int index) =>
                            debugTags[index] == ""
                                ? SizedBox(width: 16)
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(23),
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12),
                                      child:
                                          Center(child: Text(debugTags[index])),
                                    ),
                                  ),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: 12),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 4,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        body: Container(
          padding: EdgeInsets.only(left: 24, right: 24, top: 48),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(24),
            //   topRight: Radius.circular(24),
            // ),
            color: Colors.white,
          ),
          child: Text(
            value.content,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
