import 'dart:async';

import 'package:bingnuos_admin_panel/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static final CollectionReference<AppUser> _users =
      _instance.collection('users').withConverter(
            fromFirestore: (snapshot, _) =>
                AppUser.fromMap(snapshot.data() as Map<String, dynamic>),
            toFirestore: (user, _) => user.toMap(),
          );

  static Future<void> addUser(AppUser user) => _users.doc(user.uid).set(user);

  static Future<AppUser> getUser(String id) =>
      _users.doc(id).get().then((snapshot) => snapshot.data()!);
      
  static Future<bool> userExists(String id) =>
      _users.doc(id).get().then((doc) => doc.exists);
}