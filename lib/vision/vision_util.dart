import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Vision with ChangeNotifier {
  final labelerSet = <ImageLabeler>{};

  Future<FirebaseVisionImage> _getVisionImageFromImage(Image widget, BuildContext context) async {
    final ImageStream newStream = widget.image.resolve(createLocalImageConfiguration(
      context,
      size: widget.width != null && widget.height != null
          ? Size(widget.width, widget.height)
          : null,
    ));
    final Completer<ByteData> completer = Completer();
    ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo image, bool synchronousCall) {
      completer.complete(image.image.toByteData());
      newStream.removeListener(listener);
    });
    newStream.addListener(listener);
    final bytes = (await completer.future).buffer.asUint8List();
    final visionImage = FirebaseVisionImage.fromBytes(
        bytes,
        FirebaseVisionImageMetadata(
          size: Size(widget.width, widget.height),
          rawFormat: null,
          planeData: null,
        ));
    return visionImage;
  }

  Future<FirebaseVisionImage> _getVisionImageFromCachedNetworkImageProvider(
      CachedNetworkImageProvider provider) async {
    final mngr = provider.cacheManager ?? DefaultCacheManager();
    var file = await mngr.getSingleFile(provider.url, headers: provider.headers);
    final visionImage = FirebaseVisionImage.fromFile(file);
    return visionImage;
  }

  ImageLabeler _getLabeler() {
    final labeler = FirebaseVision.instance.imageLabeler();
    labelerSet.add(labeler);
    return labeler;
  }

  Future<List<ImageLabel>> processImage({
    GlobalKey imageKey,
    CachedNetworkImageProvider provider,
    String filePath,
    File file,
  }) async {
    assert(!(imageKey == null && provider == null && filePath == null && file == null),
        "Must have a parameter that is not null");
    FirebaseVisionImage visionImage;
    if (imageKey != null) {
      visionImage =
          await _getVisionImageFromImage(imageKey.currentWidget, imageKey.currentContext);
    } else if (provider != null) {
      visionImage = await _getVisionImageFromCachedNetworkImageProvider(provider);
    } else if (filePath != null) {
      visionImage = FirebaseVisionImage.fromFilePath(filePath);
    } else if (file != null) {
      visionImage = FirebaseVisionImage.fromFile(file);
    }
    final labeler = _getLabeler();
    return labeler.processImage(visionImage);
  }

  @override
  void dispose() {
    super.dispose();
    labelerSet.forEach((value) => value.close());
  }
}
