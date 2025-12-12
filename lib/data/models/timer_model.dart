import 'package:cloud_firestore/cloud_firestore.dart';

class StudyTimer {
  final String groupId;
  final bool isRunning;
  final String mode; // "focus" or "break"
  final int duration; // total session seconds
  final int timeRemaining;
  final DateTime updatedAt;

  StudyTimer({
    required this.groupId,
    required this.isRunning,
    required this.mode,
    required this.duration,
    required this.timeRemaining,
    required this.updatedAt,
  });

  factory StudyTimer.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StudyTimer(
      groupId: doc.id,
      isRunning: data['isRunning'] ?? false,
      mode: data['mode'] ?? 'focus',
      duration: data['duration'] ?? 1500,
      timeRemaining: data['timeRemaining'] ?? 1500,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isRunning': isRunning,
      'mode': mode,
      'duration': duration,
      'timeRemaining': timeRemaining,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
