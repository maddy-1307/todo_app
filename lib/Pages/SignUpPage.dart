//import 'dart:html';

import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/Pages/HomePage.dart';
import 'package:todo_app/Pages/PhoneAuthPage.dart';
import 'package:todo_app/Pages/Services/Auth_Service.dart';
import 'package:todo_app/Pages/SignInPage.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth= firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController=TextEditingController();
  TextEditingController _pwdController=TextEditingController();
  bool circular=false;
  AuthClass authClass=AuthClass();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign Up", style: TextStyle(fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              buttonItem("assest/google.svg","Continue with Google",25,()async{
               await authClass.googleSignIn(context);
              }),
              SizedBox(
                height: 15,
              ),
              buttonItem("assest/phone.svg","Continue with Mobile",30,(){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>PhoneAuthPage()));
              }),
              SizedBox(
                height: 15,
              ),
              Text("Or",style: TextStyle(color: Colors.white,fontSize: 18),),
              SizedBox(
                height: 15,
              ),
              textItem("Email...", _emailController,false),
              SizedBox(
                height: 15,
              ),
              textItem("Password...",_pwdController,true),
              SizedBox(
                height: 15,
              ),
              colorButton(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you already have an Account?", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),),
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:( builder)=>SignInPage()), (route) => false);
                    },
                    child: Text("Login", style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
    Widget buttonItem(String imgpath, String buttonName, double size,VoidCallback? ontap)
    {
      return InkWell(
        onTap:ontap ,
        child: Container(
          height: 60,
          width:  MediaQuery.of(context).size.width-60,
          child: Card(
            color: Colors.black,
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                    width: 1,
                    color: Colors.grey
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(imgpath, height: size,width: size,),
                SizedBox(
                  width: 15,
                ),
                Text(buttonName , style: TextStyle(color: Colors.white,fontSize: 17),)

              ],
            ),
          ),
        ),
      );
    }
    Widget textItem(String labelText , TextEditingController contoller,bool obscureText) {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width - 70,
        height: 55,
        child: TextFormField(
          obscureText: obscureText,
          controller: contoller,
          style: TextStyle(fontSize: 17, color: Colors.white
          ),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 17, color: Colors.white
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  width: 1,
                  color: Colors.amber
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey
              ),
            ),
          ),
        ),
      );
    }
      Widget colorButton() {
    return InkWell(
      onTap: ()async {
        setState(() {
          circular=true;
        });
        try {
          firebase_auth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _pwdController.text);
          print(userCredential.user?.email);
          setState(() {
            circular=false;
          });
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (builder)=>HomePage()),
                  (route)=>false);
        }
      catch(e)
      {
        final snackbar=SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        setState(() {
          circular=false;
        });
      }

      },

      child: Container(
        width: MediaQuery.of(context).size.width-90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.red.shade600,Colors.red.shade800]
          )
        ),
        child: Center(

          child: circular?CircularProgressIndicator():Text("Sign Up" ,style: TextStyle(color: Colors.white,fontSize: 20),
              ),
        ),
      ),
    );
      }

    }


