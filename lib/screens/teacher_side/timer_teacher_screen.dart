import 'dart:async';

import 'package:TestGround/models/student_side/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerScreenStudents extends StatefulWidget {
  TimerScreenStudents({Key key}) : super(key: key);

  @override
  _TimerScreenStudentsState createState() => _TimerScreenStudentsState();
}

class _TimerScreenStudentsState extends State<TimerScreenStudents> {
  int timer2 = 20;
  var response;

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((_) {
  //     timer = Provider.of<QuestionPaper>(
  //       context,
  //     ).getTimerFromDB();
  //   });
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() async {
  //   setState(() async {
  //     timer = await Provider.of<QuestionPaper>(context).getTimerFromDB();
  //   });

  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    final data = Provider.of<QuestionPaper>(context, listen: true);
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timer2 = 60;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuestionPaper>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () async {
                data.getTimerFromDB();
                // print(await response);
              },
              child: Text('Get time'),
            ),
            Container(
              child: Text('Rishabh: $timer2'),
            ),
          ],
        ),
      ),
    );
  }
}
