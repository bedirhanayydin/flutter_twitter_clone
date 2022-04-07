import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TweetModel {
  String id;
  String contents;
  String? image;

  TweetModel({
    required this.id,
    required this.contents,
    this.image,
  });

  factory TweetModel.fromSnapshot(DocumentSnapshot snapshot) {
    return TweetModel(
      id: snapshot.id,
      contents: snapshot["contents"],
      image: snapshot["image"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contents': contents,
      'image': image,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      id: map['id'] ?? '',
      contents: map['contents'] ?? '',
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModel.fromJson(String source) =>
      TweetModel.fromMap(json.decode(source));
}
