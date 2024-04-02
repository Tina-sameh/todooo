import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/list.dart';
import 'package:todo/pages/settings.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/widgets/bottom_sheet/add_bottom_sheet/add.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/myUser.dart';
import '../providers/themeProvider.dart';
import '../widgets/appColors.dart';
import 'auth/login/login.dart';

class Home extends StatefulWidget {
  static String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ListProvider listProvider;
  int current = 0;
  List<Widget> tabs = [
    const ListTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of(context);
    ThemeProvider themeProvider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(
         " ${AppLocalizations.of(context)!.welcome}, ${MyUser.currentUser!.username}",
          style: themeProvider.appBarTextStyle
        ),
        actions: [
          InkWell(
              onTap: (){
                listProvider.clearData();
                Navigator.pushReplacementNamed(context, Login.routeName);
              },
              child: Icon(Icons.logout,color: Colors.white,),)
        ],
      ),
      body: tabs[current],
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddBottom(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape: const StadiumBorder(
              side: BorderSide(color: Colors.white, width: 3))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor:  Theme.of(context).brightness== Brightness.light?AppColors.accent :AppColors.primiaryDark,

    );
  }

  void showAddBottom(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const AddBottomSheet(),
          );
        });
  }

  Widget buildBottomNavigationBar() {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            currentIndex: current,
            onTap: (value) {
              current = value;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 30,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 30), label: "")
            ]));
  }
}
