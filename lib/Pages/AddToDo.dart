import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';





class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  String type="";
  String category="";




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1d1e26),Color(0xff252041)],
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              IconButton(onPressed: (){},
                  icon: Icon(CupertinoIcons.arrow_left,
                             color: Colors.white,
                             size: 28,
                             ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                              Text("Create",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 33,
                                color: Colors.white,
                                letterSpacing: 4
                              ),
                              ),
                    SizedBox(
                      height: 8,
                    ),

                    Text("New Todo",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 33,
                          color: Colors.white,
                          letterSpacing: 2,
                      ),
                    ),



                    SizedBox(height: 25,),
                    label("Task Title"),
                    SizedBox(height: 12,),
                    title(),
                    SizedBox(height: 30,),
                    label("Task Type"),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        taskSelect("Important",0xff2664fa),
                          SizedBox( width: 20,
                          ),
                          taskSelect("Planned",0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 25,),
                    label("Description"),
                    SizedBox(height: 12,),
                    description(),
                    SizedBox(height: 25,),
                    label("Category"),
                    SizedBox(height: 12,),
                    Wrap(
                      runSpacing: 20,
                      children: [
                        categorySelect("Food",0xffff6d6e),
                        SizedBox( width: 20,
                        ),
                        categorySelect("Yoga/Workout",0xfff29732),
                        SizedBox( width: 20,
                        ),
                        categorySelect("Work",0xff6557ff),
                        SizedBox( width: 20,
                        ),
                        categorySelect("Study",0xff234ebd),
                        SizedBox( width: 20,
                        ),
                        categorySelect("Water",0xff2bc8d9),



                      ],
                     ),
                    SizedBox(height: 50,),
                    Button(),
                    SizedBox(height: 30,),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget Button(){
    return InkWell(
      onTap: (){
        FirebaseFirestore.instance.collection("Todo").add({
          "title":titleController.text,
          "task":type,
          "category":category,
          "description":descriptionController.text,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9)
          ],)

        ),
        child: Center(
          child: Text("Add Todo",
            style:
            TextStyle(color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget description(){
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),

      ),
      child: TextFormField(
        controller: descriptionController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,


        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Task Title",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(left: 20,right: 20)
        ),
      ),

    );
  }






  Widget taskSelect(String label, int color){
    return InkWell(
      onTap: (){
        setState(() {
          type=label;
        });
      },
    child: Chip(
      backgroundColor: type==label ?Colors.white:Color(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius
            .circular(10)
      ),
      label:
      Text(label ,
          style: TextStyle(
          color: type==label?Colors.black:Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          ),
          ),
      labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),
    ), );
     }

  Widget categorySelect(String label, int color){
    return InkWell(
      onTap: (){
        setState(() {
          category=label;
        });
      },
      child: Chip(
        backgroundColor: category==label ?Colors.white:Color(color),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius
                .circular(10)
        ),
        label:
        Text(label ,
          style: TextStyle(
            color: category==label?Colors.black:Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),
      ),
    );
  }





  Widget title(){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),

      ),
      child: TextFormField(
        controller: titleController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20,right: 20)
        ),
      ),

    );
  }

  Widget label(String label){
    return Text(label,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.5,
        letterSpacing: 0.2,

      ),
    );
  }
}
