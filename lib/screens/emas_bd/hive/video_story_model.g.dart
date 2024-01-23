// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_story_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoStoryModelAdapter extends TypeAdapter<VideoStoryModel> {
  @override
  final int typeId = 1;

  @override
  VideoStoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoStoryModel(
      id: fields[0] as int,
      catId: fields[1] as String,
      rpt: fields[2] as String,
      parentCatId: fields[3] as String,
      videoTitle: fields[4] as String,
      videoSum: fields[5] as String,
      videoPath: fields[6] as String,
      embedFrom: fields[7] as String,
      embedCode: fields[8] as String,
      coverPhoto: fields[9] as String,
      coverPhotoFromServer: fields[10] as String,
      frontDisplay: fields[11] as String,
      bodyHierarchy: fields[12] as String,
      subHierarchy: fields[13] as String,
      videoStoryModelOperator: fields[14] as String,
      entryTime: fields[15] as String,
      updateTime: fields[16] as String,
      publish: fields[17] as String,
      url: fields[18] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoStoryModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.catId)
      ..writeByte(2)
      ..write(obj.rpt)
      ..writeByte(3)
      ..write(obj.parentCatId)
      ..writeByte(4)
      ..write(obj.videoTitle)
      ..writeByte(5)
      ..write(obj.videoSum)
      ..writeByte(6)
      ..write(obj.videoPath)
      ..writeByte(7)
      ..write(obj.embedFrom)
      ..writeByte(8)
      ..write(obj.embedCode)
      ..writeByte(9)
      ..write(obj.coverPhoto)
      ..writeByte(10)
      ..write(obj.coverPhotoFromServer)
      ..writeByte(11)
      ..write(obj.frontDisplay)
      ..writeByte(12)
      ..write(obj.bodyHierarchy)
      ..writeByte(13)
      ..write(obj.subHierarchy)
      ..writeByte(14)
      ..write(obj.videoStoryModelOperator)
      ..writeByte(15)
      ..write(obj.entryTime)
      ..writeByte(16)
      ..write(obj.updateTime)
      ..writeByte(17)
      ..write(obj.publish)
      ..writeByte(18)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoStoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
