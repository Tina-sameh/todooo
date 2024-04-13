import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/todo.dart';

import '../providers/list_provider.dart';
import '../providers/themeProvider.dart';
import '../widgets/appColors.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider listProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listProvider.refreshTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    listProvider = Provider.of(context);
    return Column(
      children: [
        buildStack(context),
        Expanded(
          child: ListView.builder(
              itemCount: listProvider.todos.length,
              itemBuilder: (context, index) {
                return TodoWidget(
                  todo: listProvider.todos[index],
                );
              }),
        )
      ],
    );
  }

  Stack buildStack(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                color:  AppColors.primiary,
              )),
              const Spacer(),
            ],
          ),
        ),
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          focusDate: listProvider.selectedDate,
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateChange: (selectDate) {
            listProvider.onDateSelected(selectDate);
          },
          activeColor: Colors.white,
          dayProps: EasyDayProps(
              height: MediaQuery.of(context).size.height * .12, width: 75),
          itemBuilder:
              (context, dayNumber, dayName, monthName, fullDate, isSelected) {
            return Card(
              elevation: isSelected ? 20 : 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      dayName,
                      style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(dayNumber,
                        style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.black,
                            fontWeight: FontWeight.bold)),
                    Spacer(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
