import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper{
  const FirebaseHelper._();

  static final CollectionReference users = FirebaseFirestore.instance.collection("users");
  static final CollectionReference rooms = FirebaseFirestore.instance.collection("rooms");
  static final CollectionReference messages = FirebaseFirestore.instance.collection("messages");
  static final CollectionReference members = FirebaseFirestore.instance.collection("members");

  // static CollectionReference roomMembers(String roomId) => rooms.doc(roomId).collection("members");
  // static CollectionReference messages(String roomId) => rooms.doc(roomId).collection("messages");

  static DocumentReference userDoc(String uid) => users.doc(uid);
  static DocumentReference roomDoc(String roomId) => rooms.doc(roomId);
  static DocumentReference messageDoc(String messageId) => messages.doc(messageId);
}
