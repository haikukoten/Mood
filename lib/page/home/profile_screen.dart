import 'package:flutter/material.dart';
import 'package:mlibrary/mlibrary.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // image: DecorationImage(
          //   image:
          //       CachedNetworkImageProvider("https://w.wallhaven.cc/full/dg/wallhaven-dge7lg.png"),
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.lighten),
          // ),
          ),
      child: Column(
        children: <Widget>[
          AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.filter_center_focus),
              onPressed: () {},
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(OMIcons.moreHoriz),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Avatar(
                "https://w.wallhaven.cc/full/dg/wallhaven-dge7lg.png",
                elevation: 0,
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Miv4t",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    "@Miv4t",
                    style: TextStyle(fontSize: 14, color: Color(0xff878787)),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "96",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "情绪",
                    style: TextStyle(fontSize: 14, color: Color(0xff878787)),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "10",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "正在关注",
                    style: TextStyle(fontSize: 14, color: Color(0xff878787)),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "15",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "关注者",
                    style: TextStyle(fontSize: 14, color: Color(0xff878787)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
