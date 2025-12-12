//how messages are handled

import 'package:flutter/foundation.dart';
import '../data/models/message_model.dart';
import '../data/repositories/chat_repository.dart';

class ChatController extends ChangeNotifier {
  final ChatRepository _repo;
  final String groupId;
  final String uid;

  List<ChatMessage> messages = [];

  ChatController(this._repo, this.groupId, this.uid) {
    _repo.watchMessages(groupId).listen((msgs) {
      messages = msgs;
      notifyListeners();
    });
  }

  Future<void> sendMessage(String content) {
    return _repo.sendMessage(
      groupId: groupId,
      senderId: uid,
      content: content,
    );
  }
}
