import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:filli/models/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataStream {
  final _firestore = FirebaseFirestore.instance;

  Stream<UserData> userdata() {
    return _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => UserData(
            email: event.data()!['email'],
            username: event.data()!['username'],
            userId: event.data()!['userId'],
            imageUrl: event.data()!['image_url'],
            coverUrl: event.data()!['cover_url'],
            online: event.data()!['online'],
            status: event.data()!['status'],
            companies: event.data()!['companies'],
            projects: event.data()!['projects'],
            invitation: event.data()!['invitation']));
  }

  UserData get initialuserdata {
    return UserData(
        email: '',
        username: '',
        userId: '',
        imageUrl: '',
        coverUrl: '',
        online: {},
        status: {},
        companies: [],
        projects: [],
        invitation: []);
  }
}
