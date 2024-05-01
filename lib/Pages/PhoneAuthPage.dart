import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:todo_app/Pages/Services/Auth_Service.dart';
import 'package:otp_text_field/otp_text_field.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start=50;
  bool wait=false;
  String buttonName="Send";
  TextEditingController phoneController= TextEditingController();
  AuthClass authClass= AuthClass();
  String verificationIdFinal="";
  String smsCode="";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87 ,
        title: Text(
          "SignUp",
              style: TextStyle(color: Colors.white, fontSize: 24),

        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
                textField(),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                Text("Enter 6 digit OTP sent", style: TextStyle(color: Colors.white,fontSize: 16, ),)
                  ],
                ),
              ),







              SizedBox(
                height: 10,
              ),
              otpField(),
              SizedBox(
                height: 40,
              ),
              RichText(
                  text:TextSpan(
                    children: [
                      TextSpan(
                    text: "Send OTP again in ",
                    style: TextStyle( fontSize: 16, color: Colors.yellowAccent),
                      ),

                      TextSpan(
                        text: "00:$start",
                        style: TextStyle( fontSize: 16, color: Colors.pinkAccent),
                      ),

                      TextSpan(
                        text: "sec",
                        style: TextStyle( fontSize: 16, color: Colors.yellowAccent),
                      ),
                  ]
                  ,),



              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (){
                  authClass.signInwithPhoneNumber(verificationIdFinal, smsCode, context);

                },
                child: Container(height: 60,
                width: MediaQuery.of(context).size.width-30,
                decoration: BoxDecoration(
                  color: Color(0xffff9601),
                  borderRadius: BorderRadius.circular(15),

                ),
                  child: Text("Lets Go", style: TextStyle(fontSize: 16,color: Color(0xfffbe2ae),fontWeight: FontWeight.w700),),
                alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
       ),
    );
  }

  void startTimer(){
    const onsec=Duration(seconds: 1);
    Timer timer=Timer.periodic( onsec,(timer)
    {
      if(start==0)
        {
          setState(() {
            timer.cancel();
            wait=false;

          });
        }
      else
        {
          setState(() {
            start--;
          });

        }
    });

  }






  Widget otpField(){
    return OTPTextField(
      length: 6,

      width: MediaQuery.of(context).size.width-5,
      fieldWidth: 55,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: TextStyle(
          fontSize: 17,
              color: Colors.white,
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
       setState(() {
         smsCode=pin;
       });
      },
    );

  }









  // Widget textField(){
  //   return Container(
  //     width: MediaQuery.of(context).size.width-30,
  //     height:60,
  //     decoration: BoxDecoration(
  //       color: Color(0xff1d1d1d),
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //     child: TextFormField(
  //       controller: phoneController,
  //       decoration:InputDecoration(
  //         border: InputBorder.none,
  //
  //         hintText: "Enter Phone Number",
  //         hintStyle:TextStyle(color: Colors.white,fontSize: 17),
  //         contentPadding: const EdgeInsets.symmetric(vertical: 19,horizontal: 8),
  //         prefixIcon: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 15),
  //           child: Text(
  //               "(+91)",
  //             style: TextStyle( color: Colors.white,fontSize: 17),
  //
  //           ),
  //
  //         ),
  //           suffixIcon: InkWell(
  //             onTap: wait?null: () async {
  //               startTimer();
  //               setState(() {
  //                 start=50;
  //                 wait=true;
  //                 buttonName="Resend";
  //               });
  //               await authClass.verifyPhoneNumber("+91$phoneController.text", context,setData);
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
  //               child: Text(
  //                 buttonName,
  //                 style: TextStyle( color: wait?Colors.grey:Colors.white,fontSize: 17,fontWeight: FontWeight.bold
  //                 ),
  //
  //               ),
  //
  //             ),
  //           )
  //       )
  //     ),
  //
  //   );
  // }
  Widget textField(){
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.phone, // Ensure numeric keyboard for phone input
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter Phone Number",
          hintStyle: TextStyle(color: Colors.white, fontSize: 17),
          contentPadding: const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              "(+91)",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait ? null : () async {
              startTimer();
              setState(() {
                start = 50;
                wait = true;
                buttonName = "Resend";
              });
              // Remove non-numeric characters and prefix with country code
              String phoneNumber = "+91${phoneController.text.replaceAll(RegExp(r'\D'), '')}";
              await authClass.verifyPhoneNumber(phoneNumber, context, setData);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(color: wait ? Colors.grey : Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(String verificationId){
    setState(() {
      verificationIdFinal=verificationId;
    });
    startTimer();
  }
}
