import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LinkHistoryModel {
  final String url;
  final String shortedUrl;

  LinkHistoryModel({required this.url, required this.shortedUrl});

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'shortedUrl': shortedUrl,
    };
  }

  factory LinkHistoryModel.fromJson(Map<String, dynamic> json) {
    return LinkHistoryModel(
      url: json['url'],
      shortedUrl: json['shortedUrl'],
    );
  }
}
