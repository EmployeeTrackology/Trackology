// import 'package:flutter/material.dart';
// import 'package:emp_tracker/screens/wrapper.dart';
// // import 'package:emp_tracker/services/auth.dart';
// import 'package:emp_tracker/screens/employee_panel.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class RootPage extends StatefulWidget {
 
//   @override
//   _RootPageState createState() => _RootPageState();
// }

// enum AuthStatus{
//   notSignedIn,
//   signedIn
// }
// class _RootPageState extends State<RootPage> {
//    final FirebaseAuth auth = FirebaseAuth.instance;
//   AuthStatus _authStatus=AuthStatus.notSignedIn;

//   void initState(){
//     super.initState();
//     currentUser().then((String userId){
      
//       // setState(){
//       //   _authStatus=userId==null?AuthStatus.notSignedIn:AuthStatus.signedIn;
//       // }
//     });
//   }
//     @override
//   Widget build(BuildContext context) {
//     switch(_authStatus){
//       case AuthStatus.notSignedIn:
//         return new MyHomePage();
//       case AuthStatus.signedIn:
//         return new EmployeePanel();
//     }
    
//   }
//    Future<String> currentUser() async {
//     var user =await auth.currentUser;
//     // final User user = await _firebaseAuth.currentUser();
//     // User user=result.user;

//     print('fff');
//     print(user);
//     return user?.uid;
//   }

// }