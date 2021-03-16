import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSetting callback;

  const SettingsButton(
      {Key key,
      this.color,
      this.text,
      this.value,
      this.size = 150.0,
      this.setting,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => callback(this.setting, this.value),
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      color: this.color,
      minWidth: this.size,
    );
  }
}
