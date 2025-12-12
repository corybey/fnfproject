//room reservations

import 'package:flutter/foundation.dart';
import '../data/models/study_room_model.dart';
import '../data/repositories/room_repository.dart';

class StudyRoomController extends ChangeNotifier {
  final RoomRepository _repo;

  List<StudyRoom> rooms = [];

  StudyRoomController(this._repo) {
    _repo.watchRooms().listen((r) {
      rooms = r;
      notifyListeners();
    });
  }

  Future<void> reserveRoom(String roomId, String groupId) {
    return _repo.reserveRoom(roomId: roomId, groupId: groupId);
  }

  Future<void> releaseRoom(String roomId) {
    return _repo.releaseRoom(roomId);
  }
}
