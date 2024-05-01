import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_app/Pages/SignUpPage.dart';
import 'package:todo_app/Pages/ToDoCard.dart';
import 'package:todo_app/Pages/view_data.dart';

import 'AddToDo.dart';
import 'Services/Auth_Service.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass=AuthClass();
 final Stream<QuerySnapshot> _stream=FirebaseFirestore.instance.collection("Todo").snapshots();
List<Select> selected=[];
  int totalScheduledCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Today's Schedule",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
        ),),
        actions: [
          CircleAvatar(
            backgroundImage:AssetImage("assets/my.jpeg"),
          ),
          SizedBox( width: 25,),
        ],
        bottom: PreferredSize(
          child:Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Text("Monday 21",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),



      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,

        items: [
          BottomNavigationBarItem(

            icon: Icon(Icons.home, size: 28, color: Colors.white),
            label: ""  , // Add title for the home icon
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder)=>AddTodoPage()));
                },
              child: Container
                (height: 52,width:52, decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.indigoAccent,
                  Colors.purple,
                ])
              ),
                  child: Icon(Icons.add, size: 28, color: Colors.white)),
            ),
            label: "" , // Add title for the settings icon
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 28, color: Colors.white),
            label: "" , // Add title for the settings icon
          ),
        ],
      ),


      body: Column(
    children: [
    Expanded(
    child: StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null) {
          return Center(child: Text('No data available'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            IconData iconData = Icons.run_circle_outlined;
            Color iconColor = Colors.yellowAccent;
            //json to dart obj of data
            Map<String, dynamic> document =
            snapshot.data?.docs[index].data() as Map<String, dynamic>;
            switch (document["category"]) {
              case "Work":
                iconData = Icons.run_circle_outlined;
                iconColor = Colors.red;
                break;
              case "Water":
                iconData = Icons.water_drop;
                iconColor = Colors.blue;
                break;
              case "Study":
                iconData = Icons.laptop;
                iconColor = Colors.blue;
                break;
              case "Food":
                iconData = Icons.food_bank;
                iconColor = Colors.red;
                break;
              case "Yoga/Workout":
                iconData = Icons.sports_gymnastics;
                iconColor = Colors.red;
                break;
              default:
                iconData = Icons.run_circle_outlined;
                iconColor = Colors.yellowAccent;
            }
            selected.add(Select(snapshot.data!.docs[index].id, false));
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => ViewData(
                      document: document,
                      id: snapshot.data!.docs[index].id,
                    ),
                  ),
                );
              },
              child: TodoCard(
                title: document["title"] == null ? "null" : document["title"],
                check: selected[index].checkValue,
                iconBgColor: Colors.white,
                iconColor: iconColor,
                iconData: iconData,
                time: "10:00AM",
                index: index,
                onChange: onChange,
              ),
            );
          },
        );
      },
    ),
    ),
      Container(
        padding: EdgeInsets.all(16),
        width: 200, // Adjust width as needed
        height: 200, // Adjust height as needed
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 35, // Adjust stroke width as needed
              value: calculateCompletionPercentage() / 100,
              valueColor: AlwaysStoppedAnimation<Color>(
                calculateProgressColor(),
              ),
              backgroundColor: Colors.grey[300],
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                double fontSize = constraints.biggest.width * 0.15; // Adjust factor as needed
                return Text(
                  textAlign: TextAlign.center,
                  '${calculateCompletionPercentage().toStringAsFixed(2)}%',
                  style: TextStyle(

                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                );
              },
            ),
          ],
        ),
      )

    ],
    ),


    );
  }
  @override
  void initState() {
    super.initState();
    _initializeScheduledActivities();
  }
  void _initializeScheduledActivities() {
    FirebaseFirestore.instance
        .collection("Todo")
        .get()
        .then((querySnapshot) {
      setState(() {
        totalScheduledCount = querySnapshot.docs.length;
        selected.clear();
        querySnapshot.docs.forEach((doc) {
          selected.add(Select(doc.id, false));
        });
      });
    });
  }
  double calculateCompletionPercentage() {
    int completedCount = selected.where((element) => element.checkValue).length;
    if (totalScheduledCount == 0) {
      return 0.0;
    } else {
      return (completedCount / totalScheduledCount) * 100;
    }
  }
  Color calculateProgressColor() {
    double percentage = calculateCompletionPercentage();
    if (percentage <= 20) {
      return Colors.red;
    }
    else if (percentage <= 40) {
      return Colors.yellow;
    }
    else if (percentage <= 60) {
      return Colors.orange;
    }
    else if (percentage <= 80) {
      return Colors.lightGreen;
    }
    else {
      return Colors.green;
    }
  }

  void onChange(int index){
    setState(() {
      selected[index].checkValue=!selected[index].checkValue;
    });
  }
}
class Select{
   String id;
  bool checkValue=false;
  Select( this.id,this.checkValue,);
}










// future use
// IconButton(onPressed: () async{
// await authClass.logout();
// Navigator.pushAndRemoveUntil(context,
// MaterialPageRoute(builder: (builder)=>SignUpPage()),
// (route)=>false);
// }, icon: Icon(Icons.logout))
