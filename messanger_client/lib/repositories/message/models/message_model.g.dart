// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 2;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      author: fields[0] as String,
      target: fields[1] as String,
      isBroadcast: fields[2] as bool,
      message: fields[3] as String,
      timestamp: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.target)
      ..writeByte(2)
      ..write(obj.isBroadcast)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      author: Message._getAuthorName(json['author_id'] as int),
      target: Message._getTargetName(json['target_id'] as int),
      isBroadcast: json['is_group_message'] as bool,
      message: json['message_text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'author_id': instance.author,
      'target_id': instance.target,
      'is_group_message': instance.isBroadcast,
      'message_text': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
    };
