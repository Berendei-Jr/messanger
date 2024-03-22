import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int id;
  final int authorId;
  final int targetId;
  final bool isBroadcast;
  final String message;
  final DateTime timestamp;

  const Message({
    required this.id,
    required this.authorId,
    required this.targetId,
    required this.isBroadcast,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        authorId,
        targetId,
        isBroadcast,
      ];
}
