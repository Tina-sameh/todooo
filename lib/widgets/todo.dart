import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_dm.dart';

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
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child:
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness== Brightness.light?AppColors.white :AppColors.lightBlack,
              borderRadius:  BorderRadius.circular(20),),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primiary,),
                  height: 62,
                  width: 4,
                ),
                const SizedBox(width: 24,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.todo.title,
                          style: AppTheme.taskTitleTextStyleDark,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis
                      ),
                      const SizedBox(height: 8,),
                      Text(widget.todo.describtion,
                        style:themeProvider.smallTextStyle ,),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 4),
                    decoration: BoxDecoration(
                        color: AppColors.primiary,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Icon(
                      Icons.check, color: AppColors.white, size: 34,),
                  ),

                ),
              ],
            ),
          ),

        )
    );
  }

}
