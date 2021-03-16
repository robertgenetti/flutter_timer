import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/home/timer_model.dart';

class CountDownTimer {
  double _radius;
  bool _isActive = false;
  Duration _time;
  Duration _fullTime;
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if (this._isActive) {
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time, _radius);
    });
  }

  void startWork() async {
    await readSettings();
    this._radius = 1.0;
    this._time = Duration(minutes: this.work, seconds: 0);
    this._fullTime = _time;
  }

  void stopTimer() {
    this._isActive = false;
  }

  void startTimer() {
    if (this._time.inSeconds > 0) {
      this._isActive = true;
    }
  }

  void startBreak({bool isShort = false}) {
    this._radius = 1.0;
    this._time =
        Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    this._fullTime = _time;
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.work =
        prefs.getInt('workTime') == null ? 30 : prefs.getInt('workTime');
    this.shortBreak =
        prefs.getInt('shortBreak') == null ? 5 : prefs.getInt('shortBreak');
    this.longBreak =
        prefs.getInt('longBreak') == null ? 20 : prefs.getInt('longBreak');
  }
}
