// study room model

class StudyRoom {
  final String roomId;
  final String building;
  final int floor;
  final int capacity;
  final String status;
  final String? groupId;

  StudyRoom({
    required this.roomId,
    required this.building,
    required this.floor,
    required this.capacity,
    required this.status,
    this.groupId,
  });

  factory StudyRoom.fromMap(String id, Map data) => StudyRoom(
    roomId: id,
    building: data['building'],
    floor: data['floor'],
    capacity: data['capacity'],
    status: data['status'],
    groupId: data['groupId'],
  );

  Map<String, dynamic> toMap() => {
    'building': building,
    'floor': floor,
    'capacity': capacity,
    'status': status,
    'groupId': groupId,
  };
}
