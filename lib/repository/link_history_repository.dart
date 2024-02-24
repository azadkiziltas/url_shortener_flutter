import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/link_history_model.dart';

abstract class ILinkHistoryRepository {
  Future<List<LinkHistoryModel>> getLinkHistory();

  Future<void> saveLinkHistory(List<LinkHistoryModel> linkHistory);
}

class LinkHistoryRepository implements ILinkHistoryRepository {
  static const _key = 'linkHistory';

  @override
  Future<void> saveLinkHistory(List<LinkHistoryModel> linkHistory) async {
    final prefs = await SharedPreferences.getInstance();
    final linkHistoryJson = linkHistory.map((link) => link.toJson()).toList();
    final linkHistoryJsonString = json.encode(linkHistoryJson);
    await prefs.setString(_key, linkHistoryJsonString);
  }

  @override
  Future<List<LinkHistoryModel>> getLinkHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final linkHistoryJsonString = prefs.getString(_key);
    if (linkHistoryJsonString != null) {
      final List<dynamic> linkHistoryJson = json.decode(linkHistoryJsonString);
      return linkHistoryJson
          .map((json) => LinkHistoryModel.fromJson(json))
          .toList();
    }
    return [];
  }
}
