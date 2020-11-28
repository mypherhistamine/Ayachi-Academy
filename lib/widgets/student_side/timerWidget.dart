import 'dart:async';
import 'dart:io';

import 'package:TestGround/models/student_side/question.dart';
import 'package:TestGround/providers/testOverview.dart';
import 'package:TestGround/screens/student_side/test_overview_screen.dart';
// import 'package:TestGround/screens/teacher_side/test_overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatefulWidget {
  final fetchTime;
  final paperKey;

  const TimerWidget({Key key, this.fetchTime, this.paperKey}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer myTimer;
  DateTime currentTime = DateTime.now();
  DateTime realTimeLeft;
  int decrementor;

  DateFormat timeFormatter = DateFormat.ms();

  @override
  Future<void> initState() {
    final data = Provider.of<QuestionPaper>(context, listen: false);
    decrementor = widget.fetchTime;
    Future<int> myTimerRishabh = data.getTimerFromDB();
    realTimeLeft = DateTime.now().add(Duration(seconds: widget.fetchTime));

    myTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!currentTime.isAfter(realTimeLeft)) {
        setState(() {
          decrementor = decrementor - 1;
          realTimeLeft = realTimeLeft.subtract(Duration(seconds: 1));

          data.sendTimerToDB(decrementor, paperKey: widget.paperKey);
        });
      } else {
        Get.offAndToNamed(TestOverviewScreen.routeName);

        timer.cancel();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    myTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration timeDifference = realTimeLeft.difference(currentTime);
    final String properMinuteString = timeDifference.toString().substring(2, 4);
    final String properSecondsString =
        timeDifference.toString().substring(5, 7);

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$properMinuteString',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 4,
          ),
          Text('m'),
          SizedBox(
            width: 4,
          ),
          Text(
            '$properSecondsString',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
          ),
          SizedBox(
            width: 4,
          ),
          Text('s'),
          // RaisedButton(
          //   onPressed: () {
          //     print(timeDifference);
          //     print(properMinuteString);
          //     print(properSecondsString);
          //   },
          // )
        ],
      ),
    );
  }
}
