import 'dart:convert';

class OnlineOfflineClassModel {
  String message;

  OnlineOfflineClassModel({
    required this.message,
  });

  factory OnlineOfflineClassModel.fromRawJson(String str) => OnlineOfflineClassModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OnlineOfflineClassModel.fromJson(Map<String, dynamic> json) => OnlineOfflineClassModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
