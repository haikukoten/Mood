import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mlibrary/mlibrary.dart';
import 'package:moon/component/theme.dart';
import 'package:moon/page/welcome/register_screen.dart';
import 'package:moon/page/welcome/welcome_screen.dart';
import 'package:moon/page/welcome/nickname_screen.dart';
import 'package:moon/page/welcome/theme_select.dart';
import 'package:moon/util.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:video_player/video_player.dart';

// const ROUTE_LOGIN_PAGE = "login_page";

@RoutePage(isInitialRoute: true)
class WelcomePage extends StatefulWidget {
  static const GlobalKey<_WelcomePageState> loginPageKey =
      GlobalObjectKey(null);

  const WelcomePage({Key key = loginPageKey}) : super(key: key);

  @RoutePageBuilderFunction()
  static Widget buildPage(BuildContext context, Animation animation,
          Animation secondaryAnimation, RouteSettings settings) =>
      RegisterScreen();
  @RouteTransitionBuilderFunction()
  static Widget buildTransitions(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          RouteSettings settings) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, 1.0),
          end: Offset(0.0, 0.0),
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0, 0.0),
            end: Offset(0.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
  @RouteTransitionDurationField()
  static Duration get transitionDuration => Duration(milliseconds: 400);

  @PageRouteBuilderFuntcion()
  static Route buildPageRoute(RouteSettings settings) => PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) =>
            RegisterScreen(),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0, 1.0),
            end: Offset(0.0, 0.0),
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 0.0),
              end: Offset(0.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        ),
        transitionDuration: Duration(milliseconds: 400),
      );

  static final route = <String, RouteFactory>{
    'login_page': (RouteSettings settings) => PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) =>
            RegisterScreen(),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) =>
            // SlideTransition(
            //   position: Tween<Offset>(
            //     begin: Offset(0.0, 1.0),
            //     end: Offset(0.0, 0.0),
            //   ).animate(
            //     CurvedAnimation(
            //       parent: animation,
            //       curve: Curves.fastOutSlowIn,
            //     ),
            //   ),
            //   child: child,
            // ),
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 1.0),
                end: Offset(0.0, 0.0),
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, 0.0),
                  end: Offset(0.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            ),
        transitionDuration: Duration(milliseconds: 400)),
  };

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final duration = Duration(milliseconds: 600);
  final curve = Curves.ease;
  final PageController _pageController = PageController();
  Tween<Alignment> aligment;
  Tween<double> avatarSize;
  Tween<double> videoOpacity;

  VideoPlayerController _videoPlayerController;

  void animatedTo(int page) =>
      _pageController.animateToPage(page, duration: duration, curve: curve);

  double get _page => getPage(_pageController);

  double get _animValue => _page < 0.999999 ? _page - _page.floor() : 1;

  Future<bool> _onWillPop() async {
    int currentPage = _page.floor();
    logger.d("page=$currentPage|result=${!(currentPage - 1 > 0)}");
    if (currentPage - 1 >= 0) {
      animatedTo(currentPage - 1);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    aligment =
        AlignmentTween(begin: Alignment(0, -0.8), end: Alignment(-0.8, -0.8));
    avatarSize = Tween(begin: 54, end: 32);
    videoOpacity = Tween(begin: 1, end: 0);
    _pageController.addListener(() => setState(() {}));
    final url = "https://assets.mixkit.co/videos/99555/99555-720.mp4";
    _videoPlayerController = VideoPlayerController.network(url)
      ..initialize().then((_) => setState(() {
            _videoPlayerController.play();
            _videoPlayerController.setLooping(true);
            _videoPlayerController.setVolume(0);
            logger.d("vidoe player initialized");
          }));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setTranslateStatusBar();
    final pages = <Widget>[
      WelcomeScreen(),
      NickNameScreen(),
      ThemeSelectScreen(),
      RegisterScreen(),
    ];
    return Theme(
      data: ThemeData.dark(),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Consumer<AppTheme>(
                builder: (context, theme, child) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: theme.currentColors,
                    ),
                  ),
                  child: Center(
                    // todo 更换视频动画为flare动画
                    child: _videoPlayerController.value.initialized
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..rotateZ(pi / 2)
                              ..scale(
                                  (MediaQuery.of(context).size.width +
                                          MediaQuery.of(context).padding.top) /
                                      100,
                                  MediaQuery.of(context).size.width / 100,
                                  0),
                            // angle: 0,
                            child: Opacity(
                              opacity: videoOpacity.transform(_animValue),
                              child: Container(
                                // height: MediaQuery.of(context).size.width,
                                height: 100,

                                child: AspectRatio(
                                    aspectRatio: _videoPlayerController
                                        .value.aspectRatio,
                                    child: VideoPlayer(_videoPlayerController)),
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.white.withOpacity(0.4),
                          ),
                  ),
                ),
              ),
              PageView(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                children: pages,
              ),
              Align(
                alignment: aligment.transform(_animValue),
                child: Avatar(
                  "https://img.tuzhaozhao.com/2017/08/02/225a2c39957aea18_300x300.jpg",
                  radius: avatarSize.transform(_animValue),
                ),
              ),
              Positioned(
                right: 24.0 - 16,
                bottom: 24,
                child: Offstage(
                  offstage: _page.floor() == 0,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        onPressed: () => _pageController.previousPage(
                            duration: duration, curve: curve),
                      ),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        onPressed: () => _page.floor() != pages.length - 1
                            ? _pageController.nextPage(
                                duration: duration, curve: curve)
                            : run(() {}),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
