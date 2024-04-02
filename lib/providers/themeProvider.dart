import 'package:flutter/material.dart';

import '../widgets/appColors.dart';
import '../widgets/appTheme.dart';


class ThemeProvider extends ChangeNotifier{
  ThemeMode currentMode =ThemeMode.light;


  toggleTheme (bool darkThemeSwitchValue ){
    currentMode =darkThemeSwitchValue?ThemeMode.dark:ThemeMode.light;
    notifyListeners();}



 // String get splashScreen=>
   //   currentMode==ThemeMode.light?AppAssets.splash:AppAssets.splashDark;


  TextStyle get appBarTextStyle =>
      currentMode== ThemeMode.light? AppTheme.appBarTextStyle : AppTheme.appBarTextStyleDark;
  TextStyle get taskTitleStyle =>
      currentMode== ThemeMode.light? AppTheme.taskTitleTextStyle : AppTheme.taskTitleTextStyleDark;
  TextStyle get titleTextStyle =>
      currentMode== ThemeMode.light? AppTheme.taskTitleTextStyle : AppTheme.taskTitleTextStyleDark;
  TextStyle get smallTextStyle =>
      currentMode== ThemeMode.light? AppTheme.taskDescriptionTextStyle : AppTheme.taskDescriptionTextStyleDark;
  TextStyle get creatNewAccountMeesage =>
      currentMode== ThemeMode.light? AppTheme.creatNewAccountMeesage : AppTheme.creatNewAccountMeesageDark;
  TextStyle get settingsElements =>
      currentMode== ThemeMode.light? AppTheme.settingsElements : AppTheme.settingsElementsDark;
  Color get dropdownColor=>  currentMode==ThemeMode.light?AppColors.white:AppColors.lightBlack;
  TextStyle get buttomSheetTextTitle =>
      currentMode== ThemeMode.light? AppTheme.buttomSheetTextTitle : AppTheme.buttomSheetTextTitleDark;
  TextStyle get textFormField =>
      currentMode== ThemeMode.light? AppTheme.textFormField : AppTheme.textFormFieldDark;
}