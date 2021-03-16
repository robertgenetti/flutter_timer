import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timer/screens/settings/widgets.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController txtWork;
  TextEditingController txtShortBk;
  TextEditingController txtLongBk;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime;
  int shortBreak;
  int longBreak;
  SharedPreferences preferences;

  @override
  void initState() {
    this.txtWork = TextEditingController();
    this.txtShortBk = TextEditingController();
    this.txtLongBk = TextEditingController();
    readPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24.0);

    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Container(
            child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          childAspectRatio: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: <Widget>[
            Text("Work", style: textStyle),
            Text(""),
            Text(""),
            SettingsButton(
              color: Colors.indigo,
              text: "-",
              value: -1,
              setting: WORKTIME,
              callback: updateSetting,
            ),
            TextField(
                controller: this.txtWork,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingsButton(
              color: Colors.indigoAccent,
              text: "+",
              value: 1,
              setting: WORKTIME,
              callback: updateSetting,
            ),
            Text("Short", style: textStyle),
            Text(""),
            Text(""),
            SettingsButton(
              color: Colors.indigo,
              text: "-",
              value: -1,
              setting: SHORTBREAK,
              callback: updateSetting,
            ),
            TextField(
                controller: this.txtShortBk,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingsButton(
              color: Colors.indigoAccent,
              text: "+",
              value: 1,
              setting: SHORTBREAK,
              callback: updateSetting,
            ),
            Text(
              "Long",
              style: textStyle,
            ),
            Text(""),
            Text(""),
            SettingsButton(
              color: Colors.indigo,
              text: "-",
              value: -1,
              setting: LONGBREAK,
              callback: updateSetting,
            ),
            TextField(
                controller: this.txtLongBk,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingsButton(
              color: Colors.indigoAccent,
              text: "+",
              value: 1,
              setting: LONGBREAK,
              callback: updateSetting,
            ),
          ],
          padding: const EdgeInsets.all(20.0),
        )));
  }

  void readPreferences() async {
    this.preferences = await SharedPreferences.getInstance();
    int workTime = preferences.getInt(WORKTIME);
    if (workTime == null) {
      await preferences.setInt(WORKTIME, int.parse('30'));
    }
    int shortBreak = preferences.getInt(SHORTBREAK);
    if (workTime == null) {
      await preferences.setInt(SHORTBREAK, int.parse('5'));
    }
    int longBreak = preferences.getInt(LONGBREAK);
    if (workTime == null) {
      await preferences.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      this.txtWork.text = workTime.toString();
      this.txtShortBk.text = shortBreak.toString();
      this.txtLongBk.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = preferences.getInt(WORKTIME);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            preferences.setInt(WORKTIME, workTime);
            setState(() {
              this.txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = preferences.getInt(SHORTBREAK);
          short += value;
          if (short >= 1 && short <= 120) {
            preferences.setInt(SHORTBREAK, short);
            setState(() {
              this.txtShortBk.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = preferences.getInt(LONGBREAK);
          long += value;
          if (long >= 1 && long <= 180) {
            preferences.setInt(LONGBREAK, long);
            setState(() {
              this.txtLongBk.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
