import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'admin_panel.dart';
import 'employee_panel.dart';
import 'leave_status.dart';
import 'admin_leave_application.dart';
import 'add_employee.dart';
import 'record_attendance.dart';
import 'view_employee.dart';
import 'attend_history.dart';
import 'leave_app_form.dart';
import 'admin_holidays.dart';
import 'view_holidays.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(/**/
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffC7D3F4),
          textTheme: TextTheme(
              bodyText1: TextStyle(
            color: Colors.black,
          ))),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/LoginPage': (context) => LoginPage(),
        '/SignUpPage': (context) => SignUpPage(),
        '/admin': (context) => AdminPanel(),
        '/employee': (context) => EmployeePanel(),
        '/leave_status': (context) => MyLeaves(),
        '/admin_leave_app': (context) => LeavesApp(),
        '/add_employee': (context) => AddEmployee(),
        '/record_attendance': (context) => MarkAttendance(),
        '/view_employees': (context) => ViewEmployees(),
        '/attendace_history': (context) => Check(),
        '/leave_app_form': (context) => LeaveForm(),
        '/admin_holidays': (context) => Holiday(),
        '/emp_holidays': (context) => ViewHoliday()
      },
      home:AuthenticationWrapper(),
    )
    );
  }
}
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return MyHomePage();
    }
    return LoginPage();
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffC7D3F4),
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                "Employee Tracking App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sansita",
                    color: Color(0xff603F8F)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Image.asset('images/icon.jpg'),
            ),
            // SizedBox(
            //   height: 120,
            // ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff603FF3), Color(0xff603F83)],
                  stops: [0, 1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: openSignUp,
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff603FF3), Color(0xff603F83)],
                  stops: [0, 1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: openLogin,
                child: Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openSignUp() {
    Navigator.pushNamed(context, '/SignUpPage');
  }

  void openLogin() {
    Navigator.pushNamed(context, '/LoginPage');
  }
}
