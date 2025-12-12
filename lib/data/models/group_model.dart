// class study group

class StudyGroup {
  final String groupId;
  final String name;
  final String subject;
  final Map<String, String> members;

  StudyGroup({
    required this.groupId,
    required this.name,
    required this.subject,
    required this.members,
  });

  factory StudyGroup.fromMap(String id, Map data) => StudyGroup(
    groupId: id,
    name: data['name'],
    subject: data['subject'],
    members: Map<String, String>.from(data['members']),
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'subject': subject,
    'members': members,
  };
}
