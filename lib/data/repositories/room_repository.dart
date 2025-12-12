import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firestore_service.dart';
import '../models/study_room_model.dart';

class RoomRepository {
  final FirestoreService _db = FirestoreService.instance;

  // Stream of all rooms with real-time updates
  Stream<List<StudyRoom>> watchRooms() {
    return _db.studyRoomsCollection().snapshots().map((query) {
      return query.docs
          .map((doc) => StudyRoom.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  // Reserve room with Firestore transaction
  Future<void> reserveRoom({
    required String roomId,
    required String groupId,
  }) async {
    final ref = _db.studyRoomsCollection().doc(roomId);

    await FirebaseFirestore.instance.runTransaction((txn) async {
      final snap = await txn.get(ref);

      if (!snap.exists) throw Exception("Room does not exist.");

      final data = snap.data() as Map<String, dynamic>;
      final status = data['status'];

      if (status != 'available') {
        throw Exception("Room is not available.");
      }

      txn.update(ref, {
        'status': 'reserved',
        'groupId': groupId,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  // Release room back to available
  Future<void> releaseRoom(String roomId) async {
    await _db.studyRoomsCollection().doc(roomId).update({
      'status': 'available',
      'groupId': null,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
