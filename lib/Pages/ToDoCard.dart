import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.title, required this.iconData, required this.iconColor, required this.time, required this.check, required this.iconBgColor,required this.onChange, required this.index});
final String title;
final IconData iconData;
final Color iconColor;
final String time;
final bool check;
final Color iconBgColor;
final Function onChange;
final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  activeColor: Color(0xff6cf8a9),
                  checkColor: Color(0xff0e3e26),
                  value: check
                  ,
                  onChanged: (bool ?value){
                    onChange(index);
                  }
              ),
            ),
            data: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: Color(0xff5e616a),

            ),
          ),
          Expanded(
            child: Container(
              height:75,
              child: Card(
                shape:RoundedRectangleBorder
                  (
                     borderRadius: BorderRadius.circular(12),
                   ) ,
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(width: 15,),

                    Container(
                      height: 33,
                      width: 36,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(iconData,color:iconColor ,),
                    ),
                      SizedBox(width: 20,),
                    Expanded(
                      child: Text(title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 0.8
                             ),
                      ),
                    ),
                    Text(time,style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white,
                        letterSpacing: 0.8
                    ),),
                    SizedBox(width: 10,),




                  ],
                ),
              ),
            ),
          )
        ],

      ),
    );
  }
}
