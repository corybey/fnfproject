//scheduler

import 'package:flutter/foundation.dart';
import '../data/models/schedule_model.dart';
import '../data/repositories/schedule_repository.dart';

class ScheduleController extends ChangeNotifier {
  final ScheduleRepository _repo;
  final String groupId;

  GroupSchedule? schedule;

  ScheduleController(this._repo, this.groupId) {
    _repo.watchSchedule(groupId).listen((s) {
      schedule = s;
      notifyListeners();
    });
  }

  Future<void> proposeTime(DateTime start, DateTime end) {
    return _repo.proposeTime(
      groupId: groupId,
      start: start,
      end: end,
    );
  }

  Future<void> vote(int index, String uid, String vote) {
    return _repo.voteOnTime(
      groupId: groupId,
      index: index,
      uid: uid,
      vote: vote,
    );
  }
}
