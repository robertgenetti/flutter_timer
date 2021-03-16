import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timer/timer.dart';

import 'package:timer/screens/home/timer_model.dart';
import 'package:timer/screens/home/widgets.dart';
import 'package:timer/screens/settings/settings.dart';

class HomePage extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: Text("Deep Work Timer"),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) {
                  return <PopupMenuEntry>[
                    const PopupMenuItem<String>(
                        child: Text('Settings'), value: 'Settings')
                  ];
                },
                onSelected: (s) => goToSettings(context))
          ],
        ),
        body: Column(children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ProductivityButton(
                  color: Colors.indigoAccent,
                  text: 'Work',
                  onPressed: timer.startWork,
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ProductivityButton(
                  color: Colors.indigo,
                  text: 'Short Break',
                  onPressed: () => timer.startBreak(isShort: true),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ProductivityButton(
                  color: Colors.blueGrey[600],
                  text: 'Long Break',
                  onPressed: timer.startBreak,
                ),
              ))
            ],
          ),
          Expanded(
              child: StreamBuilder<TimerModel>(
                  initialData: TimerModel('30:00', 1.0),
                  stream: timer.stream(),
                  builder: (context, snapshot) {
                    return CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width / 2,
                        lineWidth: 10.0,
                        percent: snapshot.data.percent,
                        center: Text(snapshot.data.time,
                            style: Theme.of(context).textTheme.headline2),
                        progressColor: Colors.indigoAccent);
                  })),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ProductivityButton(
                  color: Colors.blueGrey[800],
                  text: 'Stop',
                  onPressed: timer.stopTimer,
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ProductivityButton(
                  color: Colors.indigo,
                  text: 'Start',
                  onPressed: timer.startTimer,
                ),
              )),
            ],
          )
        ]));
  }

  dynamic goToSettings(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
  }
}
