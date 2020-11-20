import 'package:flutter/material.dart';
import 'SignUpPage.dart';
import 'appbar.dart';

import 'authentication_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidePwd = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC7D3F4),
      appBar: new MyAppBar("Log In"),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              "Sign In to your account",
              style: TextStyle(
                fontSize: 30,
                fontFamily: "Sansita",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.white10.withOpacity(0.2),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                      child: TextField(
                        controller: emailController,
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
                            child: TextField(
                              controller: passwordController,
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
                          width: 130,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff603F83), Color(0xff603F83)],
                                stops: [0, 1],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: InkWell(
                            onTap: () {
                               context.read<AuthenticationService>().signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                              // Navigator.pushNamed(context, "/admin");
                            },
                            child: Center(
                              child: Text(
                                "Admin Log In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff603F83), Color(0xff603F83)],
                                stops: [0, 1],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/employee");
                            },
                            child: Center(
                              child: Text(
                                "Employee Log In",
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
          )
        ],
      ),
    );
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
}
