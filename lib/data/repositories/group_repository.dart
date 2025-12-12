import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firestore_service.dart';
import '../models/group_model.dart';

class GroupRepository {
  final FirestoreService _db = FirestoreService.instance;

  // Stream of groups a user is a member of
  Stream<List<StudyGroup>> watchUserGroups(String uid) {
    return _db.groupsCollection()
        .where("members.$uid", isGreaterThan: "")
        .snapshots()
        .map((query) => query.docs
            .map((doc) => StudyGroup.fromMap(doc.id, doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Create new group
  Future<String> createGroup({
    required String name,
    required String subject,
    required String creatorUid,
  }) async {
    final ref = await _db.groupsCollection().add({
      'name': name,
      'subject': subject,
      'createdBy': creatorUid,
      'members': {creatorUid: 'admin'},
      'activeSessionId': null,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return ref.id;
  }

  // Add user to group
  Future<void> joinGroup({
    required String groupId,
    required String uid,
  }) async {
    final ref = _db.groupsCollection().doc(groupId);

    await FirebaseFirestore.instance.runTransaction((txn) async {
      final snap = await txn.get(ref);

      if (!snap.exists) throw Exception("Group not found.");

      final data = snap.data() as Map<String, dynamic>;
      final members = Map<String, String>.from(data['members'] ?? {});

      if (!members.containsKey(uid)) {
        members[uid] = 'member';
        txn.update(ref, {'members': members});
      }
    });
  }
}
