import 'package:flutter/material.dart';
import 'package:emp_tracker/screens/authenticate/LoginPage.dart';
import 'package:emp_tracker/screens/authenticate/appbar.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:emp_tracker/services/database.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePwd = true;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId = "";
  String _password = "";
  String name = "";
  String phone = "";
  String errorMessage = '';
  String successMessage = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffC7D3F4),
        appBar: new MyAppBar("Sign Up"),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.white.withOpacity(0.3),
              ),
              child: Form(
                key: _formStateKey,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Create Your Account",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Sansita",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Full Name',
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
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter a name' : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          decoration: InputDecoration(
                              //hintText: "Example : John Doe",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailIdController,
                          validator: validateEmail,
                          onSaved: (value) {
                            _emailId = value;
                          },
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
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                validator: validatePassword,
                                controller: _passwordController,
                                onChanged: (val) {
                                  setState(() => _password = val);
                                },
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                obscureText: hidePwd,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                validator: validateConfirmPassword,
                                controller: _confirmPasswordController,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                obscureText: hidePwd,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                            (errorMessage != ''
                                ? Text(
                                    errorMessage,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : Container()),
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
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Phone no.',
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
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() => phone = val);
                          },
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff603F83), Color(0xff603F83)],
                              stops: [0, 1],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: InkWell(
                          // onTap: () async {
                          //   if (_formStateKey.currentState.validate()) {
                          //     print(email);
                          //     print(password);
                          //     signUpWithEmail(email, password);
                          //   }
                          //   // Navigator.pushNamed(context, '/LoginPage');
                          // },
                          onTap: () {
                            if (_formStateKey.currentState.validate()) {
                              _formStateKey.currentState.save();
                              signUp(_emailId, _password).then((user) {
                                if (user != null) {
                                  print('Registered Successfully.');
                                  Navigator.pushNamed(context, '/LoginPage');
                                  setState(() {
                                    successMessage =
                                        'Registered Successfully.\nYou can now navigate to Login Page.';
                                  });
                                } else {
                                  print('Error while Login.');
                                }
                              });
                            }
                          },
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }

  void openLoginPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
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

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
    }
  }

  Future<User> signUp(email, password) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      // await DatabaseService(uid:user.uid).updateUserLeave('', '', '','',false);
      assert(user != null);
      assert(await user.getIdToken() != null);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return 'Password Mismatch!!!';
    }
    return null;
  }
}
