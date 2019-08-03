// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'page/card_edit_page.dart';
import 'page/card_page.dart';
import 'page/home/home_page.dart';
import 'page/image_preview_page.dart';
import 'page/login/login_page.dart';
import 'page/photo_wall_page.dart';
import 'page/welcome/welcome_page.dart';

const ROUTE_CARD_EDIT_PAGE = 'card_edit_page';
const ROUTE_CARD_PAGE = 'card_page';
const ROUTE_HOME_PAGE = 'home_page';
const ROUTE_IMAGE_PREVIEW_PAGE = 'image_preview_page';
const ROUTE_LOGIN_PAGE = 'login_page';
const ROUTE_IMAGES_GRID_PAGE = 'images_grid_page';
const ROUTE_HOME = '/';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._cardEditPage.entries,
      ..._cardPage.entries,
      ..._homePage.entries,
      ..._imagePreviewPage.entries,
      ..._loginPage.entries,
      ..._imagesGridPage.entries,
      ..._home.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _cardEditPage = <String, RouteFactory>{
  'card_edit_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) =>
            CardEditPage(index: settings.arguments),
      ),
};
Map<String, RouteFactory> _cardPage = <String, RouteFactory>{
  'card_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => CardPage(index: settings.arguments),
      ),
};
Map<String, RouteFactory> _homePage = <String, RouteFactory>{
  'home_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ),
};
Map<String, RouteFactory> _imagePreviewPage = <String, RouteFactory>{
  'image_preview_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => ImagePreviewPage(
          imageUrl: (settings.arguments as Map<String, dynamic>)['imageUrl'],
          tag: (settings.arguments as Map<String, dynamic>)['tag'],
        ),
      ),
};
Map<String, RouteFactory> _loginPage = <String, RouteFactory>{
  'login_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
};
Map<String, RouteFactory> _imagesGridPage = <String, RouteFactory>{
  'images_grid_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => ImagesGridPage(),
      ),
};
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': WelcomePage.buildPageRoute,
};
