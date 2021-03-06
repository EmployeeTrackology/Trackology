import 'package:flutter/material.dart';
import 'package:emp_tracker/screens/authenticate/LoginPage.dart';
import 'package:emp_tracker/screens/authenticate/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String username, email, phone, password, department, role;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<User> signUp(email, password) async {
      try {
        var result = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        var user = result.user;
        // await DatabaseService(uid:user.uid).updateUserLeave('', '', '','',false);
        assert(user != null);
        assert(await user.getIdToken() != null);
        print("User Added");

        return user;
      } catch (e) {
        print(e);
        // handleError(e);
        return null;
      }
    }

    Future<void> createUser() async {
      var user = await signUp(email, password);
      print(user.uid);
      // Call the user's CollectionReference to add a new user
      return users
          .doc(user.uid)
          .set({
            'username': username, // John Doe
            //'password': password, 
            'phone': phone,
            'email': email,
            'department': department,
            'role': 'employee'
            // 42
          })
          .then((value) => Navigator.pushNamed(context, '/LoginPage'))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
        backgroundColor: Color(0xffC7D3F4),
        appBar: new MyAppBar("Sign Up"),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                         "Create Your Account",
                      style: TextStyle(
                         fontSize: 30,
                            fontFamily: "Sansita",
                            fontWeight: FontWeight.w700,
                            ),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    onChanged: (val) {
                      username = val;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                  
                    onChanged: (val) {
                      
                      password = val;
                    },
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    onChanged: (val) {
                      email = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    onChanged: (val) {
                      phone = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone no.',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    onChanged: (val) {
                      department = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Department',
                    ),
                  ),
                ),
                /*Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    onChanged: (val) {
                      var r = val.toLowerCase();
                      role = r;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Role',
                    ),
                  ),
                ),*/
                SizedBox(height: 20),
                Container(
                    height: 50,
                    decoration: BoxDecoration(  
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(5),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xff603F83),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      onPressed: createUser,
                    )),
                    SizedBox(height: 20),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an account? "),
                          InkWell(
                            onTap: openLoginPage,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
              ],
            )));
  }
   void openLoginPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

    

}
