import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._internal();
  static final FirestoreService instance = FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseFirestore get db => _db;
  // COLLECTION REFERENCES


  CollectionReference usersCollection() => _db.collection('users');

  CollectionReference studyRoomsCollection() => _db.collection('studyRooms');

  CollectionReference groupsCollection() => _db.collection('groups');

  CollectionReference schedulesCollection() => _db.collection('schedules');

  CollectionReference timersCollection() => _db.collection('timers');

  // Messages subcollection
  CollectionReference messagesCollection(String groupId) =>
      _db.collection('groupChats').doc(groupId).collection('messages');
}
