// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mood _$MoodFromJson(Map<String, dynamic> json) {
  return Mood(
    title: json['title'] as String,
    content: json['content'] as String,
    headImage: json['headImage'] as String,
    updateTime: json['updateTime'] as String,
    createTime: json['createTime'] as String,
  );
}

Map<String, dynamic> _$MoodToJson(Mood instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'headImage': instance.headImage,
      'updateTime': instance.updateTime,
      'createTime': instance.createTime,
    };
