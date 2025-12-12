//create grouping for rooms

import 'package:flutter/foundation.dart';
import '../data/models/group_model.dart';
import '../data/repositories/group_repository.dart';

class GroupController extends ChangeNotifier {
  final GroupRepository _repo;
  final String uid;

  List<StudyGroup> groups = [];

  GroupController(this._repo, this.uid) {
    _repo.watchUserGroups(uid).listen((g) {
      groups = g;
      notifyListeners();
    });
  }

  Future<String> createGroup(String name, String subject) async {
    return _repo.createGroup(
      name: name,
      subject: subject,
      creatorUid: uid,
    );
  }

  Future<void> joinGroup(String groupId) {
    return _repo.joinGroup(groupId: groupId, uid: uid);
  }
}
