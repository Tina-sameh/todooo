import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/splash.dart';
import 'package:todo/pages/Home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:FirebaseOptions(
      apiKey: "AIzaSyCI3Q7G0kgGprJsT4gbBVH7rp1kjGUSACQ",
      appId: "todo-1048b",
      messagingSenderId: "todo-1048b",
      projectId: "todo-1048b"));
  await FirebaseFirestore.instance.disableNetwork();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Splash.routeName:(_)=>Splash(),
        Home.routeName:(_)=>Home(),
      },
      initialRoute: Splash.routeName ,
    );
  }
}
