import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/myUser.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/providers/themeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../appColors.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  late ListProvider listProvider;
GlobalKey<FormState> formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    ThemeProvider themeProvider =Provider.of(context);
    return Form(
      key: formKey,
      child: Container(
color: Theme.of(context).brightness== Brightness.light?AppColors.white :AppColors.primiaryDark,
        height: MediaQuery.of(context).size.height * .45,
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Text(
              AppLocalizations.of(context)!.newTask,
              style:themeProvider.buttomSheetTextTitle,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              style: themeProvider.smallTextStyle,
              validator: (text){
                if(text?.isEmpty==true){
      return AppLocalizations.of(context)!.validTitle;
                }
                return null;
              },
              controller: title,
              decoration:  InputDecoration(
                labelText: AppLocalizations.of(context)!.title,
                labelStyle: themeProvider.textFormField
              ),
            ),
            TextFormField(
      style: themeProvider.smallTextStyle,
              validator: (text){
                if(text?.isEmpty==true){
                  return AppLocalizations.of(context)!.validDescription;
                }
                return null;
              },
              controller: description,
              decoration:  InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
                labelStyle: themeProvider.textFormField
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Text(
               AppLocalizations.of(context)!.selectDate,
              style: themeProvider.smallTextStyle,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                buildShowMyDatePicker();
              },
              child: Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                textAlign: TextAlign.center,
                style: themeProvider.smallTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () {
                  addToDoFireBase();
                },
                child: Text(
                  AppLocalizations.of(context)!.add,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  void buildShowMyDatePicker() async {
    final ThemeData theme = Theme.of(context);

    selectedDate = (await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: theme.colorScheme.primary,
              onPrimary: theme.colorScheme.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    )) ??
        selectedDate;
    setState(() {});
  }


  void addToDoFireBase() async{
    if(!formKey.currentState!.validate()){
      return;
    }
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(MyUser.currentUser!.id)
        .collection(ToDo_dm.collectionName);
    DocumentReference doc = todoCollection.doc();
    doc.set({
      "id": doc.id,
      "title": title.text,
      "description": description.text,
      "Date": selectedDate,
      "isDone": false,
    }).timeout(Duration(milliseconds:300),onTimeout:() {
      listProvider.refreshTodos();
      Navigator.pop(context);
    });
  /**/
  }
}
