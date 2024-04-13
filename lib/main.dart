import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/auth/login/login.dart';
import 'package:todo/pages/auth/register/register.dart';
import 'package:todo/pages/splash.dart';
import 'package:todo/pages/Home.dart';
import 'package:todo/pages/update_task.dart';
import 'package:todo/providers/langProvider.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/providers/themeProvider.dart';
import 'package:todo/widgets/appTheme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCI3Q7G0kgGprJsT4gbBVH7rp1kjGUSACQ",
          appId: "todo-1048b",
          messagingSenderId: "todo-1048b",
          projectId: "todo-1048b"));

  //await FirebaseFirestore.instance.disableNetwork();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ListProvider()),
      ChangeNotifierProvider(create: (context) => LangProvider()),
      ChangeNotifierProvider(create: (context) =>ThemeProvider())
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LangProvider language=Provider.of(context);
    ThemeProvider themeProvider=Provider.of(context);
    return MaterialApp(
      theme:AppTheme.lightTheme ,
      darkTheme:AppTheme.darkTheme ,
      themeMode: themeProvider.currentMode ,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'),
      ],
      locale: Locale(language.currentLocale),
      routes: {
        Splash.routeName: (_) => const Splash(),
        Home.routeName: (_) => const Home(),
        Login.routeName: (_) =>  Login(),
        Register.routeName: (_) =>  Register(),
        TaskEdit.routeName: (_) =>  TaskEdit(),
      },
      initialRoute: Splash.routeName,
    );
  }
}
