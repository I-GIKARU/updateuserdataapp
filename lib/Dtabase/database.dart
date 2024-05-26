// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference profileList =
  FirebaseFirestore.instance.collection('profileInfo');

  Future<void> createUserData(
      String name, String gender, int score, String uid) async {
    return await profileList
        .doc(uid)
        .set({'name': name, 'gender': gender, 'score': score});
  }

  Future updateUserList(String name, String gender, int score, String uid) async {
    return await profileList.doc(uid).update({
      'name': name, 'gender': gender, 'score': score
    });
  }

  Future<List<Map<String, dynamic>>> getUsersList() async {
    List<Map<String, dynamic>> itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          itemsList.add(doc.data() as Map<String, dynamic>);
        }
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
