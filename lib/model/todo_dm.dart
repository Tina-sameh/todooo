class ToDo_dm {
  static const String collectionName="todo";
  String title;
  String describtion;
  bool isDone;
  DateTime date;
  String id;

  ToDo_dm(
      {required this.title,
        required this.describtion,
        required this.date,
        required this.id,
        required this.isDone});
}