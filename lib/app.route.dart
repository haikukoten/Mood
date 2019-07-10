// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:moon/page/image_preview.dart';
import 'package:moon/page/card_edit.dart';
import 'package:moon/page/home.dart';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._imagePreviewPage.entries,
      ..._cardEditPage.entries,
      ..._home.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _imagePreviewPage = <String, RouteFactory>{
  'image_preview_page': (RouteSettings settings) => MaterialPageRoute(
      builder: (BuildContext context) => ImagePreviewPage(
            imageUrl: (settings.arguments as Map<String, dynamic>)['imageUrl'],
            tag: (settings.arguments as Map<String, dynamic>)['tag'],
          ))
};
Map<String, RouteFactory> _cardEditPage = <String, RouteFactory>{
  'card_edit_page': (RouteSettings settings) => MaterialPageRoute(
      builder: (BuildContext context) => CardEditPage(
            index: settings.arguments,
          ))
};
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => HomePage())
};

const ROUTE_IMAGE_PREVIEW_PAGE = 'image_preview_page';
const ROUTE_CARD_EDIT_PAGE = 'card_edit_page';
const ROUTE_HOME_PAGE = '/';
const ROUTE_HOME = '/';
