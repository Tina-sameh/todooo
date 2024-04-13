import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/providers/themeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../model/myUser.dart';
import '../providers/list_provider.dart';
import '../widgets/appColors.dart';
import 'Home.dart';

class TaskEdit extends StatefulWidget {
  static const String routeName = "update";

  const TaskEdit({super.key});

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  DateTime selectedDate = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ToDo_dm? todo;
    ThemeProvider themeProvider = Provider.of(context);
    if (todo == null) {
      todo = ModalRoute.of(context)!.settings.arguments as ToDo_dm;
      title.text = todo.title;
      description.text = todo.describtion;
      selectedDate =
          DateTime.fromMillisecondsSinceEpoch(todo.date.millisecondsSinceEpoch);
    }

    Future<void> update() async {
      CollectionReference todoCollection = FirebaseFirestore.instance
          .collection(MyUser.collectionName)
          .doc(MyUser.currentUser!.id)
          .collection(ToDo_dm.collectionName);
      DocumentReference doc = todoCollection.doc(todo!.id);
      doc.update({
        "title": title.text,
        "description": description.text,
        "Date": Timestamp.fromDate(selectedDate),
      });
      ListProvider listProvider =
          Provider.of<ListProvider>(context, listen: false);
      await listProvider.refreshTodos();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "To Do List",
          style: themeProvider.appBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: AppColors.primiary,
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: Form(
                    key: formKey,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.white
                            : AppColors.primiaryDark,
                      ),
                      height: MediaQuery.of(context).size.height * .7,
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.editTask,
                            style: themeProvider.buttomSheetTextTitle,
                            textAlign: TextAlign.center,
                          ),
                          Expanded(
                            child: TextFormField(
                              style: themeProvider.smallTextStyle,
                              validator: (text) {
                                if (text?.isEmpty == true) {
                                  return AppLocalizations.of(context)!
                                      .validTitle;
                                }
                                return null;
                              },
                              controller: title,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.title,
                                  labelStyle: themeProvider.textFormField),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              style: themeProvider.smallTextStyle,
                              validator: (text) {
                                if (text?.isEmpty == true) {
                                  return AppLocalizations.of(context)!
                                      .validDescription;
                                }
                                return null;
                              },
                              controller: description,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.description,
                                  labelStyle: themeProvider.textFormField),
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
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  buildShowMyDatePicker();
                                });
                              },
                              child: Text(
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                textAlign: TextAlign.center,
                                style: themeProvider.smallTextStyle
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                              onPressed: () async {
                                await update();
                                Navigator.pushNamed(context, Home.routeName);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.save,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
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
}
