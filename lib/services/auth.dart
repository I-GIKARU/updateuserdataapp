import 'package:firebase_auth/firebase_auth.dart';
import 'package:updateuserdata/Dtabase/database.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createNewUser(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await DatabaseManager().createUserData(name, 'Male', 100, user.uid);
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error.toString());
    }
  }
}
