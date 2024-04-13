import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/myUser.dart';
import 'package:todo/providers/themeProvider.dart';
import 'package:todo/widgets/dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Home.dart';

class Register extends StatefulWidget {
  static const String routeName = "Register";

  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController rePasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xff5c9bea),
        title: Text(AppLocalizations.of(context)!.register,
            style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              TextFormField(
                style: themeProvider.textFormField,
                controller: userNameController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.user,
                    labelStyle: themeProvider.textFormField),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return AppLocalizations.of(context)!.invalidUser;
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                style: themeProvider.textFormField,
                controller: emailController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    labelStyle: themeProvider.textFormField),
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return AppLocalizations.of(context)!.emptyEmail;
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
              TextFormField(
                style: themeProvider.textFormField,
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    labelStyle: themeProvider.textFormField),
                validator: (text) {
                  if (text == null || text.length < 6) {
                    return AppLocalizations.of(context)!.invalidPass;
                  }
                  return null;
                },
              ),
              TextFormField(
                style: themeProvider.textFormField,
                controller: rePasswordController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.repassword,
                    labelStyle: themeProvider.textFormField),
                validator: (text) {
                  if (text == null || text.length < 6) {
                    return AppLocalizations.of(context)!.emptyEmail;
                  }
                  if (text != passwordController.text) {
                    return AppLocalizations.of(context)!.match;
                  }
                  return null;
                },
              ),
              const Spacer(
                flex: 3,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    registerAcount();
                  },
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.createAccount,
                          style: const TextStyle(color: Colors.white)),
                      const Spacer(),
                      const Icon(Icons.arrow_right)
                    ],
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void registerAcount() async {
    // if (!formKey.currentState!.validate()) return;
    try {
      //show loading
      DialogUtils.showLoading(context);
      //hide
      UserCredential authCreds = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      MyUser.currentUser = MyUser(
          id: authCreds.user!.uid,
          username: userNameController.text,
          email: emailController.text);
      await registerUserToFireStore(MyUser.currentUser!);
      DialogUtils.hideLoading(context);
      Navigator.pushNamed(context, Home.routeName);

      registerUserToFireStore(MyUser.currentUser!);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoading(context);
      if (e.code == 'weak-password') {
        DialogUtils.showError(context, AppLocalizations.of(context)!.weak);
      }
      if (e.code == 'email-already-in-use') {
        DialogUtils.showError(context, AppLocalizations.of(context)!.exit);
      } else {
        DialogUtils.showError(context, AppLocalizations.of(context)!.tryAgain);
      }
    }
  }

  Future<void> registerUserToFireStore(MyUser user) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    DocumentReference newDoc = collectionReference.doc(user.id);
    await newDoc.set(user.toJson());
  }
}
