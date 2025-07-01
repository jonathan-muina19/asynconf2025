import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String speaker;
  final String subject;
  final String avatar;
  final String type;
  final Timestamp timestamp;

  Event({
    required this.speaker,
    required this.subject,
    required this.avatar,
    required this.type,
    required this.timestamp,
  });

  //
  factory Event.fromData(dynamic data) {
    return Event(
      speaker: data['speaker'],
      subject: data['subject'],
      avatar: data['avatar'].toString().toLowerCase(),
      type: data['type'],
      timestamp: data['date'],
    );
  }
}
