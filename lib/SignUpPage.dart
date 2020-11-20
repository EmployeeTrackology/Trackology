import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'appbar.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePwd = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC7D3F4),
      appBar:new MyAppBar("Sign Up"),
      body: SingleChildScrollView(
        child:Container(
          margin:EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            color: Colors.white.withOpacity(0.3),
          ),
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
                child: TextField(
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
                child: TextField(
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
                child: TextField(
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
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: InkWell(
                  onTap: () {
                  Navigator.pushNamed(context, '/LoginPage');
                  },
                  child: Center(
                    child: Text(
                      "Log In",
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
        )
      ),
    );
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
}
