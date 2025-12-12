import 'package:cloud_firestore/cloud_firestore.dart';

class ProposedTime {
  final DateTime start;
  final DateTime end;
  final Map<String, String> votes; // uid -> "yes"/"no"

  ProposedTime({
    required this.start,
    required this.end,
    required this.votes,
  });

  factory ProposedTime.fromMap(Map<String, dynamic> data) {
    return ProposedTime(
      start: (data['start'] as Timestamp).toDate(),
      end: (data['end'] as Timestamp).toDate(),
      votes: Map<String, String>.from(data['votes'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': Timestamp.fromDate(start),
      'end': Timestamp.fromDate(end),
      'votes': votes,
    };
  }
}

class GroupSchedule {
  final String groupId;
  final List<ProposedTime> proposedTimes;
  final DateTime? finalTime;

  GroupSchedule({
    required this.groupId,
    required this.proposedTimes,
    this.finalTime,
  });

  factory GroupSchedule.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GroupSchedule(
      groupId: doc.id,
      proposedTimes: (data['proposedTimes'] as List? ?? [])
          .map((e) => ProposedTime.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      finalTime: data['finalTime'] != null
          ? (data['finalTime'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'proposedTimes': proposedTimes.map((e) => e.toMap()).toList(),
      'finalTime': finalTime != null ? Timestamp.fromDate(finalTime!) : null,
    };
  }
}
