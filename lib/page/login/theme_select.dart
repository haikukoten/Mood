import 'package:flutter/material.dart';
import 'package:mlibrary/mlibrary.dart';
import 'package:moon/component/theme.dart';
import 'package:moon/widget/theme_circle.dart';
import 'package:moon/widget/theme_page_view.dart';

class ThemeSelectScreen extends StatelessWidget {
  final GlobalKey<ThemePageViewState> pageKey = GlobalKey();

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
              "你好呀，泠音！你最喜欢的主题是哪一个？",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ActionX<AppTheme>(
                builder: (context, theme, child) => ThemePageView(
                  // key: pageKey,
                  itemCount: AppTheme.colorList.length,
                  currentThemeIndex: theme.colorIndex,
                  itemBuilder: (BuildContext context, int index) => ThemeCircle(
                    colors: AppTheme.colorList[index],
                    onPress: () {
                      theme.colorIndex = index;
                      // todo 1. 添加主题切换动画
                      // todo 2. 使选择的主题居中
                      // pageKey.currentState.animatedTo(index);
                    },
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                "下一步",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              shape: StadiumBorder(),
              onPressed: () {},
            ),
          ),
          SizedBox(height: 24.0 * 2),
        ],
      ),
    );
  }
}
