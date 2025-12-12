//user model foor student

class UserModel {
  final String uid;
  final String name;
  final String email;
  final List<String> joinedGroups;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.joinedGroups,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'],
      name: json['name'],
      email: json['email'],
      joinedGroups: List<String>.from(json['joinedGroups'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'name': name,
      'email': email,
      'joinedGroups': joinedGroups,
    };
  }
}
