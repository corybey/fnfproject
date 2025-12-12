import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firestore_service.dart';
import '../models/message_model.dart';

class ChatRepository {
  final FirestoreService _db = FirestoreService.instance;

  // Stream of messages (real-time)
  Stream<List<ChatMessage>> watchMessages(String groupId) {
    return _db.messagesCollection(groupId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((query) => query.docs.map(ChatMessage.fromDoc).toList());
  }

  // Send new message
  Future<void> sendMessage({
    required String groupId,
    required String senderId,
    required String content,
  }) async {
    final msg = ChatMessage(
      id: '',
      senderId: senderId,
      content: content,
      timestamp: DateTime.now(),
    );

    await _db.messagesCollection(groupId).add(msg.toMap());
  }
}
