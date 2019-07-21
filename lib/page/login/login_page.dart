import 'package:flutter/material.dart';
import 'package:mlibrary/mlibrary.dart';
import 'package:moon/app.route.dart';
import 'package:moon/page/login/nickname_screen.dart';
import 'package:moon/page/login/welcome_screen.dart';
import 'package:moon/util.dart';
import 'package:route_annotation/route_annotation.dart';

// const ROUTE_LOGIN_PAGE = "login_page";

@RoutePage(isInitialRoute: true)
class LoginPage extends StatefulWidget {
  static const GlobalKey<_LoginPageState> loginPageKey = GlobalObjectKey(null);

  const LoginPage({Key key = loginPageKey}) : super(key: key);
  // static final route = <String, RouteFactory>{
  //   'login_page': (RouteSettings settings) => PageRouteBuilder(
  //       pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) =>
  //           LoginPage(),
  //       transitionsBuilder: (BuildContext context, Animation<double> animation,
  //               Animation<double> secondaryAnimation, Widget child) =>
  //           // SlideTransition(
  //           //   position: Tween<Offset>(
  //           //     begin: Offset(0.0, 1.0),
  //           //     end: Offset(0.0, 0.0),
  //           //   ).animate(
  //           //     CurvedAnimation(
  //           //       parent: animation,
  //           //       curve: Curves.fastOutSlowIn,
  //           //     ),
  //           //   ),
  //           //   child: child,
  //           // ),
  //           SlideTransition(
  //             position: Tween<Offset>(
  //               begin: Offset(0.0, 1.0),
  //               end: Offset(0.0, 0.0),
  //             ).animate(animation),
  //             child: SlideTransition(
  //               position: Tween<Offset>(
  //                 begin: Offset(0.0, 0.0),
  //                 end: Offset(0.0, 0.0),
  //               ).animate(secondaryAnimation),
  //               child: child,
  //             ),
  //           ),
  //       transitionDuration: Duration(milliseconds: 400)),
  // };

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final duration = Duration(milliseconds: 600);
  final curve = Curves.ease;
  final PageController _pageController = PageController();
  Tween<Alignment> aligment;
  Tween<double> avatarSize;

  void goToPage(int page) =>
      _pageController.animateToPage(page, duration: duration, curve: curve);

  double get _page {
    try {
      return _pageController.page;
    } catch (e) {
      return 0;
    }
  }

  double get _animValue => _page < 0.999999 ? _page - _page.floor() : 1;

  Future<bool> _onWillPop() async {
    int currentPage = _page.floor();
    logger.d("page=$currentPage|result=${!(currentPage - 1 > 0)}");
    if (currentPage - 1 >= 0) {
      goToPage(currentPage - 1);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    aligment = AlignmentTween(begin: Alignment(0, -0.8), end: Alignment(-0.8, -0.8));
    avatarSize = Tween(begin: 54, end: 32);
    _pageController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFFE2B0FF),
                      Color(0xFF9F44D3),
                    ],
                  ),
                ),
              ),
              PageView(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  WelcomeScreen(),
                  NickNameScreen(),
                ],
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
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_up),
                      onPressed: () =>
                          _pageController.previousPage(duration: duration, curve: curve),
                    ),
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () => _page.floor() != 1
                          ? _pageController.nextPage(duration: duration, curve: curve)
                          : Navigator.pushNamed(context, ROUTE_HOME_PAGE),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
