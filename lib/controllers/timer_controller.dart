//timer for rooms

import 'dart:async';
import 'package:flutter/foundation.dart';
import '../data/models/study_timer_model.dart';
import '../data/repositories/timer_repository.dart';

class TimerController extends ChangeNotifier {
  final TimerRepository _repo;
  final String groupId;

  StudyTimer? timer;
  StreamSubscription? _sub;

  TimerController(this._repo, this.groupId) {
    _sub = _repo.watchTimer(groupId).listen((t) {
      timer = t;
      notifyListeners();
    });
  }

  Future<void> initTimer(int seconds) {
    return _repo.initTimer(groupId: groupId, durationSeconds: seconds);
  }

  Future<void> updateTimer({
    required bool isRunning,
    required String mode,
    required int timeRemaining,
  }) {
    return _repo.updateTimerState(
      groupId: groupId,
      isRunning: isRunning,
      mode: mode,
      timeRemaining: timeRemaining,
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
