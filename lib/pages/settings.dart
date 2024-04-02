import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/langProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/themeProvider.dart';
import '../widgets/appColors.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of(context);

    LangProvider language=Provider.of(context);
    String select="en";
    return Scaffold(
      backgroundColor : Theme.of(context).brightness== Brightness.light?AppColors.accent :AppColors.primiaryDark,
      body: Column(
        children: [
          Container(color: Color(0xff5a99e6),height: MediaQuery.of(context).size.height*0.08,),
          Text(AppLocalizations.of(context)!.lang,style: themeProvider.settingsElements,),
          Padding(
            padding: EdgeInsets.all(12),
            child: DropdownButton(
              dropdownColor: themeProvider.dropdownColor ,
              value: select,
                items:  [
              DropdownMenuItem(value: "en", child: Text("English",style: themeProvider.smallTextStyle,),),
              DropdownMenuItem(value: "ar", child: Text("العربيه",style: themeProvider.smallTextStyle,),)
                    ],
                isExpanded: true,
            onChanged: (newValue){
              select = newValue!;
              language.setCurrentLocale(select);
              setState(() {});
            }),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.dark,style:themeProvider.smallTextStyle ,),
                Spacer(),
                Switch(
                    value:themeProvider.currentMode==ThemeMode.dark, onChanged: (newValue){
                  themeProvider.toggleTheme(newValue);
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
