import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firestore_service.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  final FirestoreService _db = FirestoreService.instance;

  // Watch schedule for a group
  Stream<GroupSchedule?> watchSchedule(String groupId) {
    return _db.schedulesCollection().doc(groupId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return GroupSchedule.fromDoc(doc);
    });
  }

  // Propose a new meeting time
  Future<void> proposeTime({
    required String groupId,
    required DateTime start,
    required DateTime end,
  }) async {
    final ref = _db.schedulesCollection().doc(groupId);

    await FirebaseFirestore.instance.runTransaction((txn) async {
      final snap = await txn.get(ref);

      List<dynamic> proposed = [];

      if (snap.exists) {
        proposed = snap.data()!['proposedTimes'] ?? [];
      }

      proposed.add({
        'start': Timestamp.fromDate(start),
        'end': Timestamp.fromDate(end),
        'votes': {},
      });

      txn.set(ref, {'proposedTimes': proposed}, SetOptions(merge: true));
    });
  }

  // Vote yes/no for a proposed time
  Future<void> vote({
    required String groupId,
    required int index,
    required String uid,
    required String vote, // "yes" / "no"
  }) async {
    final ref = _db.schedulesCollection().doc(groupId);

    await FirebaseFirestore.instance.runTransaction((txn) async {
      final snap = await txn.get(ref);
      if (!snap.exists) return;

      final data = snap.data()!;
      final proposed = List<Map<String, dynamic>>.from(data['proposedTimes']);

      final entry = Map<String, dynamic>.from(proposed[index]);
      final votes = Map<String, String>.from(entry['votes'] ?? {});

      votes[uid] = vote;
      entry['votes'] = votes;

      proposed[index] = entry;

      txn.update(ref, {'proposedTimes': proposed});
    });
  }
}
