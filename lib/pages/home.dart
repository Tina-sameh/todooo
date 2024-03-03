import 'package:flutter/material.dart';
import 'package:todo/pages/list.dart';
import 'package:todo/pages/settings.dart';
import 'package:todo/widgets/bottom_sheet/add_bottom_sheet/add.dart';

class Home extends StatefulWidget {
  static String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int current=0;
  List<Widget> tabs=[
 ListTab(),
    SettingsTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xff5c9bea),
      ),
      body:tabs[current],
      floatingActionButton: FloatingActionButton(
          onPressed:(){
            showModalBottomSheet(context: context,
                builder:(context){
              return AddBottomSheet();
                });
          },
        child:Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.blue,
          shape:StadiumBorder(side: BorderSide(color: Colors.white,width: 3))),
      floatingActionButtonLocation:FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor: Color(0xffddead9),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomAppBar(
      height: 90,
      shape: CircularNotchedRectangle(),
      notchMargin:12,
      clipBehavior: Clip.hardEdge,
       child:BottomNavigationBar(
         selectedItemColor: Colors.blue,
        currentIndex: current,
          onTap: (value){
          current=value;
          setState(() {

          });
          },
          items:[
            BottomNavigationBarItem(icon:Icon(Icons.list,size: 30,),label: ""),
            BottomNavigationBarItem(icon:Icon(Icons.settings,size: 30),label: "")
          ])
    );
  }
}
