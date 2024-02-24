import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:url_shortener/data/models/shorted_link_model.dart';

import '../constants/constants.dart';

class ShortedLinkProvider {
  final Dio _dio = Dio(BaseOptions(baseUrl: Constants.BASE_URL));

  Future<ShortedLinkModel> getShortedLink(String url) async {
    try {
      final response =
          await _dio.get("shorten_link?apikey=${Constants.API_KEY}&url=$url");
      return shortedLinkModelFromJson(response.toString());
    } catch (e) {
      if (e is DioException) {
        return Future.error((e.response?.statusCode).toString());
      }
      return Future.error(e);
    }
  }
}
