import 'dart:convert';

class ClassDetailsModel {
  Data data;

  ClassDetailsModel({
    required this.data,
  });

  factory ClassDetailsModel.fromRawJson(String str) => ClassDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClassDetailsModel.fromJson(Map<String, dynamic> json) => ClassDetailsModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String sectionId;
  String subjectId;
  String partId;
  String employeeId;
  String divisionId;
  String day;
  String start;
  String end;
  String room;
  String active;
  String createdAt;
  String updatedAt;
  String topic;
  String description;
  String medium;
  String zoomUrl;
  DateTime date;
  String bookPdf;
  String levelName;
  String sectionName;
  String subjectName;
  DayWise dayWise;
  String duration;
  String totalStudents;
  String presentStudents;
  String status;

  Data({
    required this.id,
    required this.sectionId,
    required this.subjectId,
    required this.partId,
    required this.employeeId,
    required this.divisionId,
    required this.day,
    required this.start,
    required this.end,
    required this.room,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.topic,
    required this.description,
    required this.medium,
    required this.zoomUrl,
    required this.date,
    required this.bookPdf,
    required this.levelName,
    required this.sectionName,
    required this.subjectName,
    required this.dayWise,
    required this.duration,
    required this.totalStudents,
    required this.presentStudents,
    required this.status,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    sectionId: json["section_id"].toString(),
    subjectId: json["subject_id"].toString(),
    partId: json["part_id"].toString(),
    employeeId: json["employee_id"].toString(),
    divisionId: json["division_id"].toString(),
    day: json["day"].toString(),
    start: json["start"].toString(),
    end: json["end"].toString(),
    room: json["room"].toString(),
    active: json["active"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    topic: json["topic"].toString(),
    description: json["description"].toString(),
    medium: json["medium"].toString(),
    zoomUrl: json["zoom_url"].toString(),
    date: DateTime.parse(json["date"]),
    bookPdf: json["book_pdf"].toString(),
    levelName: json["level_name"].toString(),
    sectionName: json["section_name"].toString(),
    subjectName: json["subject_name"].toString(),
    dayWise: DayWise.fromJson(json["dayWise"]),
    duration: json["duration"].toString(),
    totalStudents: json["totalStudents"].toString(),
    presentStudents: json["presentStudents"].toString(),
    status: json["status"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "section_id": sectionId,
    "subject_id": subjectId,
    "part_id": partId,
    "employee_id": employeeId,
    "division_id": divisionId,
    "day": day,
    "start": start,
    "end": end,
    "room": room,
    "active": active,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "topic": topic,
    "description": description,
    "medium": medium,
    "zoom_url": zoomUrl,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "book_pdf": bookPdf,
    "level_name": levelName,
    "section_name": sectionName,
    "subject_name": subjectName,
    "dayWise": dayWise.toJson(),
    "duration": duration,
    "totalStudents": totalStudents,
    "presentStudents": presentStudents,
    "status": status,
  };
}

class DayWise {
  String topic;

  DayWise({
    required this.topic,
  });

  factory DayWise.fromRawJson(String str) => DayWise.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DayWise.fromJson(Map<String, dynamic> json) => DayWise(
    topic: json["topic"],
  );

  Map<String, dynamic> toJson() => {
    "topic": topic,
  };
}
