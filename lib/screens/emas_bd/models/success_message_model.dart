import 'dart:convert';

class ResponseMessageModel {
  String message;

  ResponseMessageModel({
    required this.message,
  });

  factory ResponseMessageModel.fromRawJson(String str) => ResponseMessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseMessageModel.fromJson(Map<String, dynamic> json) => ResponseMessageModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
