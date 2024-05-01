


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo_app/Pages/AddToDo.dart';
import 'package:todo_app/Pages/HomePage.dart';
import 'package:todo_app/Pages/Services/Auth_Service.dart';
import 'package:todo_app/Pages/SignInPage.dart';
import 'package:todo_app/Pages/SignUpPage.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage =SignUpPage();
  AuthClass authClass=AuthClass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  void checkLogin() async{
    String? token= await authClass.getToken();
    if(token!=null)
      {
        setState(() {
          currentPage=HomePage();
        });
      }
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomePage(),
    );
  }
}




