import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/myUser.dart';
import '../model/todo_dm.dart';

class ListProvider extends ChangeNotifier {
  List<ToDo_dm> todos = [];
  DateTime selectedDate = DateTime.now();

  onDateSelected(DateTime newDate) {
    selectedDate = newDate;
    refreshTodos();
    notifyListeners();
  }

  Future<void> refreshTodos() async {
    todos.clear();
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(MyUser.currentUser!.id)
        .collection(ToDo_dm.collectionName);
    QuerySnapshot querySnapShot = await todoCollection.orderBy("Date",descending:true).get();
    List<QueryDocumentSnapshot<Object?>> docList = querySnapShot.docs;

    for (QueryDocumentSnapshot doc in docList) {
      Map json = doc.data() as Map;
      Timestamp dateToTimeStamp = json["Date"];
      ToDo_dm todo = ToDo_dm(
          title: json["title"],
          describtion: json["description"],
          date: dateToTimeStamp.toDate(),
          id: json["id"],
          isDone: json["isDone"]);
      if (selectedDate.year == todo.date.year &&
          selectedDate.month == todo.date.month &&
          selectedDate.day == todo.date.day) {
        todos.add(todo);
      }
    }
    notifyListeners();
  }

  void clearData() {
    todos = [];
    selectedDate = DateTime.now();
    MyUser.currentUser = null;
  }
}
