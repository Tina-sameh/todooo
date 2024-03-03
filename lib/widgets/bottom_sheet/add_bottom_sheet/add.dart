import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo_dm.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate=DateTime.now();
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height* .45,
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add New Task",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: title,
            decoration: InputDecoration(
              labelText: "Title",
            ),
          ),
          TextField(
            controller: description,
            decoration: InputDecoration(
              labelText: "Description",
            ),
          ),
          SizedBox(height:10,),
          Text(
            "Select date",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              buildShowMyDatePicker();
            },
            child: Text(
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)
            ),
              onPressed: (){
              addToDoFireBase();
              },
              child: Text("add",style: TextStyle(fontSize: 20,color: Colors.white),))
        ],
      ),
    );
  }

  void buildShowMyDatePicker() async{
    selectedDate= (await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: selectedDate,
        lastDate: DateTime.now().add(Duration(days: 365))))?? selectedDate;
    setState(() {

    });
  }

  void addToDoFireBase() {
    CollectionReference todoCollection= FirebaseFirestore.instance.collection(ToDo_dm.collectionName);
    DocumentReference doc=  todoCollection.doc();
        doc.set({
      "id":doc.id,
      "title":title.text,
        "description": description.text,
      "Date":selectedDate,
      "isDone":false ,
        }).timeout(Duration(microseconds: 300,),onTimeout:(){
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
          }      Navigator.pop(context);
    });
  }
}
