import 'dart:convert';

ShortedLinkModel shortedLinkModelFromJson(String str) =>
    ShortedLinkModel.fromJson(json.decode(str));

String shortedLinkModelToJson(ShortedLinkModel data) =>
    json.encode(data.toJson());

class ShortedLinkModel {
  String statusCode;
  String data;

  ShortedLinkModel({
    required this.statusCode,
    required this.data,
  });

  factory ShortedLinkModel.fromJson(Map<String, dynamic> json) =>
      ShortedLinkModel(
        statusCode: json["status_code"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data,
      };
}
