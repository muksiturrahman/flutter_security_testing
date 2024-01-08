import 'dart:convert';

class AllClassesModel {
  int id;
  String sectionName;
  String levelName;
  String day;
  String start;
  String end;
  String room;
  String topicName;
  DateTime date;
  String duration;

  AllClassesModel({
    required this.id,
    required this.sectionName,
    required this.levelName,
    required this.day,
    required this.start,
    required this.end,
    required this.room,
    required this.topicName,
    required this.date,
    required this.duration,
  });

  factory AllClassesModel.fromRawJson(String str) => AllClassesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllClassesModel.fromJson(Map<String, dynamic> json) => AllClassesModel(
    id: json["id"],
    sectionName: json["section_name"],
    levelName: json["level_name"],
    day: json["day"],
    start: json["start"],
    end: json["end"],
    room: json["room"],
    topicName: json["topic_name"],
    date: DateTime.parse(json["date"]),
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "section_name": sectionName,
    "level_name": levelName,
    "day": day,
    "start": start,
    "end": end,
    "room": room,
    "topic_name": topicName,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "duration": duration,
  };
}
