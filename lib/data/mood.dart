import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mood.g.dart';

@JsonSerializable()
class Mood {
  @JsonKey(ignore: true)
  String id;
  String title;
  String content;
  String headImage;
  String updateTime;
  String createTime;

  Mood(
      {this.id,
      this.title,
      this.content,
      this.headImage,
      this.updateTime,
      this.createTime});

  factory Mood.fromJson(Map<String, dynamic> json, [String id]) =>
      _$MoodFromJson(json)..id = id;

  Map<String, dynamic> toJson() => _$MoodToJson(this);
}

class MoodProvider with ChangeNotifier {
  final _moodRef = Firestore.instance.collection('mood');
  var _documents = <Mood>[];
  bool _isListening = false;

  List<Mood> get documents => _documents;

  Future<Mood> document(String id) async {
    final doc = await _moodRef.document(id).get();
    if (doc != null) {
      return Mood.fromJson(doc.data, doc.documentID);
    }
    return null;
  }

  Future<Mood> updateOrCreate(Mood mood, {bool merge = false}) async {
    bool setId = mood.id == null;
    final doc = _moodRef.document(mood.id);
    await doc.setData(mood.toJson(), merge: merge);
    if (setId) mood.id = doc.documentID;
    return mood;
  }

  Future<void> delete(String id) async {
    final doc = _moodRef.document(id);
    await doc.delete();
  }

  @override
  void addListener(listener) {
    listen();
    // refresh();
    super.addListener(listener);
  }

  void listen() {
    if (!_isListening) {
      _moodRef.snapshots().listen((data) {
        _isListening = true;
        _documents = data.documents
            .map((doc) => Mood.fromJson(doc.data, doc.documentID))
            .toList();
        debugPrint("doc update：size=${_documents.length}");
        notifyListeners();
      });
    }
  }

  Future refresh([bool force = false]) async {
    if (force || !_isListening) {
      _isListening = true;
      final documentSnapshot = await _moodRef.getDocuments();
      _documents = documentSnapshot.documents
          .map((doc) => Mood.fromJson(doc.data, doc.documentID))
          .toList();
      debugPrint("doc refresh：size=${_documents.length}");
      notifyListeners();
    }
  }
}
