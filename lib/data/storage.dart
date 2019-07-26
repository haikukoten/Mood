import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class StorageProvider with ChangeNotifier {
  // storageBucket: "gs://mood-9277.appspot.com"
  bool _isInit = false;
  FirebaseStorage _storage;
  StorageReference _storageReference;

  @override
  void addListener(listener) {
    _init();
    super.addListener(listener);
  }

  void _init() {
    if (_isInit) return;
    _isInit = true;
    _storage = FirebaseStorage();
    _storageReference = _storage.ref();
  }

  StorageUploadTask upload(
    String parent,
    File file, {
    void onProgress(double progress),
    Function onError,
    void onCompleted(String url),
    bool listen = true,
  }) {
    final fileReference = _storageReference.child(parent + basename(file.path));
    final task = fileReference.putFile(file);
    if (listen) {
      task.events.listen(
        (data) => onProgress(
            data.snapshot.bytesTransferred / data.snapshot.totalByteCount),
        onError: onError,
        onDone: () async => onCompleted(await fileReference.getDownloadURL()),
      );
    }
    return task;
  }

  Future<String> getDownloadUrl(String path) async {
    return await _storageReference.child(path).getDownloadURL();
  }
}
