import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:mlibrary/mlibrary.dart';

@RoutePage(params: [RouteParameter("imageUrl"), RouteParameter("tag")])
class ImagePreviewPage extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final PhotoController controller = PhotoController();

  ImagePreviewPage({Key key, this.imageUrl, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Hero(
        tag: tag ?? "image_preview_tag",
        child: PhotoView(
          controller: controller,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
