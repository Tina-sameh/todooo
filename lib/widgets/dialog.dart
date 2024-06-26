import 'package:flutter/material.dart';

abstract class DialogUtils{
  static void showLoading(BuildContext context){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
      return const AlertDialog(
          content: Row(
            children: [
              Text("Loading..."),
              Spacer(),
              CircularProgressIndicator()
            ],
          ));
  });
}
static void hideLoading(BuildContext context){
    Navigator.pop(context);
}
static void showError(BuildContext context , String message){
    showDialog(context: context,
        builder: (_){
      return AlertDialog(
          title: Text("Error",),
          content: Text(message),
        actions: [
          TextButton(onPressed: (){
Navigator.pop(context);
          }, child: Text("OK"))
        ],
      );
        });
}
}