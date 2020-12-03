import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:emp_tracker/screens/authenticate/SignUpPage.dart';
import 'package:emp_tracker/screens/authenticate/appbar.dart';
// import 'package:emp_tracker/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
// a3:dc:34:cf:f6:b9:80:1d:3d:4b:6e:3f:b6:fa:3a:bb:6a:39:f6:56

class _LoginPageState extends State<LoginPage> {
  bool hidePwd = true;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffC7D3F4),
        resizeToAvoidBottomPadding: false,
        appBar: new MyAppBar("Log In"),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            color: Colors.white10.withOpacity(0.2),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Form(
              key: _formStateKey,
              autovalidate: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Log in to your account",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Sansita",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  (errorMessage != ''
                      ? Center(
                          child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ))
                      : Container()),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Email Address',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: TextFormField(
                      validator: validateEmail,
                      onSaved: (value) {
                        _emailId = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailIdController,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      decoration: InputDecoration(
                          //hintText: "Example : test@test.com",
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            validator: validatePassword,
                            onSaved: (value) {
                              _password = value;
                            },
                            controller: _passwordController,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            obscureText: hidePwd,
                            decoration: InputDecoration(
                                // hintText: "****",
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: IconButton(
                            onPressed: togglePwdVisibility,
                            icon: hidePwd == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff603F83), Color(0xff603F83)],
                              stops: [0, 1],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: InkWell(
                          onTap: () {
                            if (_formStateKey.currentState.validate()) {
                              _formStateKey.currentState.save();
                              signIn(_emailId, _password).then((user) {
                                User user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.uid) //user.uid
                                      .get()
                                      .then(
                                          (DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                     
                              print('Document data: ${documentSnapshot.data()['role']}');
                                          if (documentSnapshot.data()['role']=='admin')
                                          {
                                             Navigator.pushNamed(context, "/admin");
                                          }
                                          else{
                                            Navigator.pushNamed(context, "/employee");
                                          }
                                          
                                    } else {
                                      print(
                                          'Document does not exist on the database');
                                    }
                                  });
                                  print(' Logged in successfully.');
                                  setState(() {
                                    successMessage =
                                        'Logged in successfully.\nYou can now navigate to Home Page.';
                                  });
                                  Navigator.pushNamed(context, "/admin");
                                } else {
                                  print('Error while Login.');
                                }
                              });
                            }
                          },
                          child: Center(
                            child: Text(
                              " Log In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account? "),
                      InkWell(
                        onTap: openSignUpPage,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )));
  }

  void openSignUpPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void togglePwdVisibility() {
    hidePwd = !hidePwd;
    setState(() {});
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Enter Valid Email Id!!!';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'Password is empty!!!';
    }
    if (value.length < 6) {
      return 'Enter an password of length greater than 7';
    }
    return null;
  }

  Future<User> signIn(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      assert(user != null);
      assert(await user.user.getIdToken() != null);

      final currentUser = auth.currentUser;
      assert(user.user.uid == currentUser.uid);
      return user.user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        setState(() {
          errorMessage = 'User Not Found!!!';
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        setState(() {
          errorMessage = 'Wrong Password!!!';
        });
        break;
    }
  }
}
