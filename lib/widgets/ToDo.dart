import 'package:flutter/material.dart';

import '../model/todo_dm.dart';

class ToDo extends StatelessWidget {
  final ToDo_dm todo;
   ToDo({super.key,required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 22,horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 24,horizontal: 18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: <Widget>[
              Container(
                decoration: BoxDecoration(
      color:Colors.blue,
          borderRadius: BorderRadius.circular(2)
                ),
                height: 62,
                width: 4,
              ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.title,style: TextStyle(color: Colors.blue,fontSize: 25),),
                Text(todo.describtion)
              ],
            ),
          ),
          Container(
           padding: EdgeInsets.symmetric(vertical: 7,horizontal: 22),
            decoration: BoxDecoration(
              color: Colors.blue,
borderRadius: BorderRadius.circular(6)
            ),
            child: Image.asset("assets/icon_check.png"),
          )
            ],
          )
    );
  }
}
