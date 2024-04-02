import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/myUser.dart';
import 'package:todo/widgets/dialog.dart';
import '../../../providers/themeProvider.dart';
import '../../../widgets/appTheme.dart';
import '../../Home.dart';
import '../register/register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  static const String routeName = "Login";

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController PasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login,style: const TextStyle(color:Colors.white),),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              TextFormField(
                style:  themeProvider.textFormField,
                controller: emailController,
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.email,labelStyle: themeProvider.smallTextStyle),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Empty email are not allowed";
                  }
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if (!emailValid) {
                    return AppLocalizations.of(context)!.emailFormat;
                  }
                  return null;
                },
              ),
              SizedBox(height: 5,),
              TextFormField(
                style: themeProvider.textFormField,
                controller: PasswordController,
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.password,labelStyle:  themeProvider.smallTextStyle),
                validator: (text) {
                  if (text == null || text.length < 6) {
                    return AppLocalizations.of(context)!.wrongPass;
                  }
                  return null;
                },
              ),
              const Spacer(flex: 3,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)
                ),
                  onPressed: () {
                    loginAccount();
                  },
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.login,style:const TextStyle(color: Colors.white),),
                      const Spacer(),
                      const Icon(Icons.arrow_right)
                    ],
                  )),
              const SizedBox(height: 10,),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Register.routeName);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.message,
                    style: themeProvider.creatNewAccountMeesage,
                    textAlign: TextAlign.center,
                  )),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void loginAccount() async {
    try {
      DialogUtils.showLoading(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: PasswordController.text);
      MyUser.currentUser = await getUserFromFireStore(credential.user!.uid);

      DialogUtils.hideLoading(context);
      Navigator.pushReplacementNamed(context, Home.routeName);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoading(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showError(context, AppLocalizations.of(context)!.noUser);
      } else if (e.code == 'wrong-password') {
        DialogUtils.showError(
            context, AppLocalizations.of(context)!.falsePass);
      } else {
        DialogUtils.showError(context, AppLocalizations.of(context)!.wrong);
      }
    }
  }

  Future<MyUser> getUserFromFireStore(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    DocumentReference userDoc = collectionReference.doc(id);
    DocumentSnapshot documentSnapshot = await userDoc.get();
    Map json = documentSnapshot.data() as Map;
    MyUser myUser = MyUser.fromJson(json);
    return myUser;
  }
}
