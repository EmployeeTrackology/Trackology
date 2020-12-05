import 'package:flutter/material.dart';
import 'package:emp_tracker/screens/authenticate/LoginPage.dart';
import 'package:emp_tracker/screens/authenticate/SignUpPage2.dart';
import 'package:emp_tracker/screens/admin_panel.dart';
import 'package:emp_tracker/screens/employee_panel.dart';
import 'package:emp_tracker/screens/leave_status.dart';
import 'screens/admin_leave_application.dart';
import 'package:emp_tracker/screens/add_employee.dart';
import 'package:emp_tracker/screens/record_attendance.dart';
import 'package:emp_tracker/screens/view_employee.dart';
import 'package:emp_tracker/screens/attend_history.dart';
import 'package:emp_tracker/screens/leave_app_form.dart';
import 'package:emp_tracker/screens/admin_holidays.dart';
import 'package:emp_tracker/screens/view_holidays.dart';
import 'package:emp_tracker/screens/attendance_summary.dart';
import 'package:emp_tracker/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/emp_holidays': (context) => ViewHoliday(),
        '/attendance_summary':(context)=>AttendanceSummary()
      },
      // home:AuthenticationWrapper(),
    );
  }
}
