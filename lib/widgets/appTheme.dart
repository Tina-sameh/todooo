import 'package:flutter/material.dart';
import 'appColors.dart';

abstract class AppTheme {

  static const TextStyle appBarTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle taskTitleTextStyle = TextStyle(fontSize: 22, color: AppColors.primiaryDark);
  static const TextStyle settingsElements = TextStyle(fontSize: 22, color: AppColors.primiaryDark);
  static const TextStyle taskDescriptionTextStyle = TextStyle(fontSize: 14, color: AppColors.lightBlack);
  static  TextStyle textFormField = TextStyle(fontSize: 14, color: AppColors.lightBlack.withOpacity(.5));
  static const TextStyle bottomSheetTitleTextStyle = TextStyle(fontSize: 20, color: AppColors.primiaryDark);
  static const TextStyle creatNewAccountMeesage = TextStyle(fontSize: 14, color: AppColors.primiaryDark,decoration: TextDecoration.underline,);
  static const TextStyle dialogText = TextStyle(fontSize: 18, color: AppColors.primiaryDark,);
  static const TextStyle buttomSheetTextTitle =  TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);

  static const TextStyle creatNewAccountMeesageDark = TextStyle(fontSize: 14, color: AppColors.white,decoration: TextDecoration.underline,);
  static const TextStyle appBarTextStyleDark = TextStyle(
    color: AppColors.primiaryDark,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  static  TextStyle textFormFieldDark = TextStyle(fontSize: 14, color: AppColors.white.withOpacity(.5));
  static const TextStyle buttomSheetTextTitleDark =  TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
  static const TextStyle settingsElementsDark = TextStyle(fontSize: 22, color: AppColors.white);
  static const TextStyle taskTitleTextStyleDark = TextStyle(fontSize: 22, color: AppColors.primiary);
  static const TextStyle taskDescriptionTextStyleDark = TextStyle(fontSize: 14, color: AppColors.white);
  static const TextStyle bottomSheetTitleTextStyleDark = TextStyle(fontSize: 20, color: AppColors.primiaryDark);
    static const TextStyle dialogTextDark = TextStyle(fontSize: 18, color: AppColors.primiaryDark,);



  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primiary,
        elevation: 0,
        titleTextStyle: appBarTextStyle,
      ),
      dialogTheme: DialogTheme(

        contentTextStyle: dialogText
      ),
      dialogBackgroundColor: Colors.white,
bottomSheetTheme: BottomSheetThemeData(
  backgroundColor: Colors.red
),
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primiary,
          onPrimary: AppColors.primiary,
          secondary: AppColors.primiary,
          onSecondary: AppColors.primiary,
          error: Colors.red,
          onError: Colors.red,
          background: AppColors.accent,
          onBackground: AppColors.primiary,
          surface: Colors.transparent,
          onSurface: Colors.transparent),
      floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: AppColors.primiary,
        shape: const StadiumBorder(
          side: BorderSide(color: Colors.white, width: 7)),),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primiary,

      ),
      scaffoldBackgroundColor: AppColors.accent,
      dividerTheme: DividerThemeData(thickness: 3, color: AppColors.primiary));


  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primiaryDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primiary,
      elevation: 0,
      titleTextStyle: appBarTextStyle,
    ),
    dialogTheme: DialogTheme(
        contentTextStyle: dialogTextDark
    ),
    floatingActionButtonTheme:
    const FloatingActionButtonThemeData(backgroundColor: AppColors.primiary,shape: const StadiumBorder(
        side: BorderSide(color:AppColors.lightBlack, width: 3)),),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:AppColors.lightBlack ,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.primiary,
      unselectedItemColor: Colors.white,

    ),
    scaffoldBackgroundColor: AppColors.primiaryDark,
    dialogBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primiaryDark,
        onPrimary: AppColors.primiaryDark,
        secondary: AppColors.lightBlack,
        onSecondary: AppColors.lightBlack,
        error: Colors.red,
        onError: Colors.red,
        background: AppColors.primiaryDark,
        onBackground:AppColors.primiary,
        surface: Colors.transparent,
        onSurface: Colors.transparent
    ),
  );
}