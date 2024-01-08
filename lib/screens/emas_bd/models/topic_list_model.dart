import 'dart:convert';

class TopicListModel {
  List<TopicListDatum> data;

  TopicListModel({
    required this.data,
  });

  factory TopicListModel.fromRawJson(String str) => TopicListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopicListModel.fromJson(Map<String, dynamic> json) => TopicListModel(
    data: List<TopicListDatum>.from(json["data"].map((x) => TopicListDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TopicListDatum {
  String id;
  String teacherId;
  String classScheduleId;
  String medium;
  String topic;
  String description;
  String zoomUrl;
  String zoomId;
  String zoomPassword;
  String tagPreviousTopics;
  String previousMaterial;
  String topicFile;
  DateTime date;
  String status;
  String createdAt;
  String updatedAt;
  String deletedAt;

  TopicListDatum({
    required this.id,
    required this.teacherId,
    required this.classScheduleId,
    required this.medium,
    required this.topic,
    required this.description,
    required this.zoomUrl,
    required this.zoomId,
    required this.zoomPassword,
    required this.tagPreviousTopics,
    required this.previousMaterial,
    required this.topicFile,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory TopicListDatum.fromRawJson(String str) => TopicListDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopicListDatum.fromJson(Map<String, dynamic> json) => TopicListDatum(
    id: json["id"].toString(),
    teacherId: json["teacher_id"].toString(),
    classScheduleId: json["class_schedule_id"].toString(),
    medium: json["medium"].toString(),
    topic: json["topic"].toString(),
    description: json["description"].toString(),
    zoomUrl: json["zoom_url"].toString(),
    zoomId: json["zoom_id"].toString(),
    zoomPassword: json["zoom_password"].toString(),
    tagPreviousTopics: json["tag_previous_topics"].toString(),
    previousMaterial: json["previous_material"].toString(),
    topicFile: json["topic_file"].toString(),
    date: DateTime.parse(json["date"]),
    status: json["status"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    deletedAt: json["deleted_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "teacher_id": teacherId,
    "class_schedule_id": classScheduleId,
    "medium": medium,
    "topic": topic,
    "description": description,
    "zoom_url": zoomUrl,
    "zoom_id": zoomId,
    "zoom_password": zoomPassword,
    "tag_previous_topics": tagPreviousTopics,
    "previous_material": previousMaterial,
    "topic_file": topicFile,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
