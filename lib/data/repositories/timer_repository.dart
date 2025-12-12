import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firestore_service.dart';
import '../models/timer_model.dart';

class TimerRepository {
  final FirestoreService _db = FirestoreService.instance;

  // Watch the timer document in real time
  Stream<StudyTimer?> watchTimer(String groupId) {
    return _db.timersCollection().doc(groupId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return StudyTimer.fromDoc(doc);
    });
  }

  // Initialize timer for group
  Future<void> initTimer({
    required String groupId,
    int durationSeconds = 1500,
  }) async {
    final now = DateTime.now();

    final timer = StudyTimer(
      groupId: groupId,
      isRunning: false,
      mode: 'focus',
      duration: durationSeconds,
      timeRemaining: durationSeconds,
      updatedAt: now,
    );

    await _db.timersCollection().doc(groupId).set(
          timer.toMap(),
          SetOptions(merge: true),
        );
  }

  // Update timer state
  Future<void> updateTimer({
    required String groupId,
    required bool isRunning,
    required String mode,
    required int timeRemaining,
  }) async {
    await _db.timersCollection().doc(groupId).update({
      'isRunning': isRunning,
      'mode': mode,
      'timeRemaining': timeRemaining,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
