import 'package:hive/hive.dart';

part 'video_story_model.g.dart';

@HiveType(typeId: 1)
class VideoStoryModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String catId;

  @HiveField(2)
  final String rpt;

  @HiveField(3)
  final String parentCatId;

  @HiveField(4)
  String videoTitle;

  @HiveField(5)
  final String videoSum;

  @HiveField(6)
  final String videoPath;

  @HiveField(7)
  final String embedFrom;

  @HiveField(8)
  final String embedCode;

  @HiveField(9)
  final String coverPhoto;

  @HiveField(10)
  final String coverPhotoFromServer;

  @HiveField(11)
  final String frontDisplay;

  @HiveField(12)
  final String bodyHierarchy;

  @HiveField(13)
  final String subHierarchy;

  @HiveField(14)
  final String videoStoryModelOperator;

  @HiveField(15)
  final String entryTime;

  @HiveField(16)
  final String updateTime;

  @HiveField(17)
  final String publish;

  @HiveField(18)
  final String url;

  VideoStoryModel({
    required this.id,
    required this.catId,
    required this.rpt,
    required this.parentCatId,
    required this.videoTitle,
    required this.videoSum,
    required this.videoPath,
    required this.embedFrom,
    required this.embedCode,
    required this.coverPhoto,
    required this.coverPhotoFromServer,
    required this.frontDisplay,
    required this.bodyHierarchy,
    required this.subHierarchy,
    required this.videoStoryModelOperator,
    required this.entryTime,
    required this.updateTime,
    required this.publish,
    required this.url,
  });

  factory VideoStoryModel.fromJson(Map<String, dynamic> json) => VideoStoryModel(
    id: json["id"],
    catId: json["cat_id"].toString(),
    rpt: json["rpt"].toString(),
    parentCatId: json["parent_cat_id"].toString(),
    videoTitle: json["video_title"].toString(),
    videoSum: json["video_sum"].toString(),
    videoPath: json["video_path"].toString(),
    embedFrom: json["embed_from"].toString(),
    embedCode: json["embed_code"].toString(),
    coverPhoto: json["cover_photo"].toString(),
    coverPhotoFromServer: json["cover_photo_from_server"].toString(),
    frontDisplay: json["front_display"].toString(),
    bodyHierarchy: json["body_hierarchy"].toString(),
    subHierarchy: json["sub_hierarchy"].toString(),
    videoStoryModelOperator: json["operator"].toString(),
    entryTime: json["entry_time"].toString(),
    updateTime: json["update_time"].toString(),
    publish: json["publish"].toString(),
    url: json["url"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_id": catId,
    "rpt": rpt,
    "parent_cat_id": parentCatId,
    "video_title": videoTitle,
    "video_sum": videoSum,
    "video_path": videoPath,
    "embed_from": embedFrom,
    "embed_code": embedCode,
    "cover_photo": coverPhoto,
    "cover_photo_from_server": coverPhotoFromServer,
    "front_display": frontDisplay,
    "body_hierarchy": bodyHierarchy,
    "sub_hierarchy": subHierarchy,
    "operator": videoStoryModelOperator,
    "entry_time": entryTime,
    "update_time": updateTime,
    "publish": publish,
    "url": url,
  };
}
