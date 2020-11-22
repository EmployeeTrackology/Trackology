import 'package:emp_tracker/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj
  TheUser _userFirebase(User user){
    return (user !=null? TheUser(uid:user.uid) : null);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign in with email and password
  //register with email and password
  //signout
}
