import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/pages/update_task.dart';
import 'package:todo/providers/langProvider.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../model/myUser.dart';
import '../providers/themeProvider.dart';
import 'appColors.dart';
import 'appTheme.dart';

class TodoWidget extends StatefulWidget {
  final ToDo_dm todo;

  const TodoWidget({super.key, required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    LangProvider langProvider=Provider.of(context);
    return Padding(
        padding: const EdgeInsets.all(25.0),
        child: Card(
            elevation: 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          setState(() {
                            delete() ;
                          });
                        },
                        label: AppLocalizations.of(context)!.delete,
                        icon: Icons.delete,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        /*BorderRadius.only(
                          bottomRight: langProvider.currentLocale=="en"? Radius.circular(0):Radius.circular(18),
                          topRight: langProvider.currentLocale=="en"? Radius.circular(0):Radius.circular(18),
                            topLeft:langProvider.currentLocale=="en"? Radius.circular(18):Radius.circular(0),
                            bottomLeft: langProvider.currentLocale=="en"? Radius.circular(18):Radius.circular(0)),
*/
                      ),
                    ],
                  ),

                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.pushNamed(context, TaskEdit.routeName,arguments: widget.todo);
                        },
                        label:AppLocalizations.of(context)!.edit ,
                        icon: Icons.edit,
                        backgroundColor: AppColors.primiary,
                        borderRadius: BorderRadius.circular(20),
                        /*BorderRadius.only(
                            bottomRight: langProvider.currentLocale=="en"? const Radius.circular(18):const Radius.circular(0),
                            topRight: langProvider.currentLocale=="en"? const Radius.circular(18):const Radius.circular(0),
                          topLeft: langProvider.currentLocale=="en"? const Radius.circular(0):const Radius.circular(18),
                          bottomLeft: langProvider.currentLocale=="en"? const Radius.circular(0):const Radius.circular(18),
                      )*/
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.white
                          : AppColors.lightBlack,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 18),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:widget.todo.isDone? Colors.green: AppColors.primiary,
                          ),
                          height: 62,
                          width: 4,
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.todo.title,
                                  style: widget.todo.isDone?AppTheme.taskTitleTextStyleDark.copyWith(color: Colors.green):AppTheme.taskTitleTextStyleDark,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.todo.describtion,
                                style: themeProvider.smallTextStyle,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await update();
                          },
                          child: widget.todo.isDone
                              ?  Text(
                                 AppLocalizations.of(context)!.done ,
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: AppColors.primiary,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColors.white,
                                    size: 34,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
  Future<void> delete() async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(MyUser.currentUser!.id)
        .collection(ToDo_dm.collectionName);
    DocumentReference doc = todoCollection.doc(widget.todo.id);
    doc.delete(
    );
    ListProvider listProvider =
    Provider.of<ListProvider>(context, listen: false);
    await listProvider.refreshTodos();
  }
  Future<void> update() async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(MyUser.currentUser!.id)
        .collection(ToDo_dm.collectionName);
    DocumentReference doc = todoCollection.doc(widget.todo.id);
    doc.update({
      "isDone": !widget.todo.isDone,
    });
    ListProvider listProvider =
        Provider.of<ListProvider>(context, listen: false);
    await listProvider.refreshTodos();
  }

}
