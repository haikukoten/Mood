// import 'package:flutter/material.dart';
// import 'package:mlibrary/mlibrary.dart';
// import 'package:moon/app.route.dart';
// import 'package:moon/page/login/login_page.dart';
// import 'package:route_annotation/route_annotation.dart';

// // const ROUTE_HOEM = "/";
// // const ROUTE_WELCOME_PAGE = "/";

// // @RoutePage(isInitialRoute: true)
// // @RoutePage(generatedRoute: false)
// class WelcomePage extends StatelessWidget {
//   // static final route = <String, RouteFactory>{
//   //   '/': (RouteSettings settings) => PageRouteBuilder(
//   //       pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) =>
//   //           WelcomePage(),
//   //       transitionsBuilder: (BuildContext context, Animation<double> animation,
//   //               Animation<double> secondaryAnimation, Widget child) =>
//   //           SlideTransition(
//   //             position: Tween<Offset>(
//   //               begin: Offset(0.0, 0.0),
//   //               end: Offset(0.0, 0),
//   //             ).animate(animation),
//   //             child: SlideTransition(
//   //               position: Tween<Offset>(
//   //                 begin:Offset(0.0, 0),
//   //                 end: Offset(0.0, -1.0),
//   //               ).animate(secondaryAnimation),
//   //               child: child,
//   //             ),
//   //           ),
//   //       transitionDuration: Duration(milliseconds: 400)),
//   // };

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.dark(),
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 Color(0xFFE2B0FF),
//                 Color(0xFF9F44D3),
//               ],
//             ),
//           ),
//           constraints: BoxConstraints.expand(),
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 25.0 + 24,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(32.0),
//                 child: Hero(
//                   tag: "welcome_avatar",
//                   child: Avatar(
//                       "https://img.tuzhaozhao.com/2017/08/02/225a2c39957aea18_300x300.jpg"),
//                 ),
//               ),
//               Text(
//                 "欢迎你，",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 "我是Mood",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 24,
//               ),
//               Text(
//                 "你是这儿一位新的小伙伴哦",
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//               Spacer(),
//               SizedBox(
//                 width: 140,
//                 child: RaisedButton(
//                   color: Colors.white,
//                   elevation: 8,
//                   highlightElevation: 4,
//                   shape: StadiumBorder(),
//                   onPressed: () => Navigator.pushNamed(context, ROUTE_LOGIN_PAGE),
//                   child: Text(
//                     "Hi Mood",
//                     style: TextStyle(
//                       color: Color(0xFF9F44D3),
//                     ),
//                   ),
//                 ),
//               ),
//               FlatButton(
//                 child: Text("我已拥有账号"),
//                 shape: StadiumBorder(),
//                 onPressed: () {},
//               ),
//               SizedBox(
//                 height: 96,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
