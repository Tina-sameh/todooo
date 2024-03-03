import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/ToDo.dart';

import '../model/todo_dm.dart';

class ListTab extends StatefulWidget {

  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<ToDo_dm> todos=[];

  @override
  Widget build(BuildContext context) {
    if(todos.isEmpty){
    refreshTodos();}
    return Column(
      children: [
Expanded(
  child: ListView.builder(
      itemCount:todos.length,
      itemBuilder:(context , index){
    return ToDo(todo: todos[index],);
  }),
)
      ],
    );
  }

  refreshTodos() async {
    CollectionReference todoCollection =FirebaseFirestore.instance.collection(ToDo_dm.collectionName);
    QuerySnapshot querySnapShot= await todoCollection.get();
    List<QueryDocumentSnapshot<Object?>> docList= querySnapShot.docs;

    for(var doc in docList){
      Map json= doc.data() as Map;
      Timestamp dateToTimeStamp= json["Date"];
      ToDo_dm todo= ToDo_dm(title: json["title"],
          describtion: json["description"],
          date:dateToTimeStamp.toDate() ,
          id: json["id"],
          isDone: json["isDone"]);
    }
    setState(() {
    });
  }
}
