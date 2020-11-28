import 'dart:math';

import 'package:TestGround/models/student_side/question.dart';
import 'package:TestGround/screens/student_side/test_overview_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ScoreScreen extends StatefulWidget {
  final int maxMarks;
  final String paperKey;
  ScoreScreen({this.maxMarks, this.paperKey});

  // static final tweenAnimater = Tween<double>(begin: 0, end: pi * 1.8);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

int scoredMarks;

class _ScoreScreenState extends State<ScoreScreen> {
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      final data = Provider.of<QuestionPaper>(context, listen: false);
      setState(() {
        isLoading = true;
      });
      scoredMarks = await data.getScoreFromDB(paperKey: widget.paperKey);
      setState(() {
        isLoading = false;
      });
    });

    print(scoredMarks);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final marksRatio = scoredMarks / widget.maxMarks;

    // final data = Provider.of<QuestionPaper>(context);
    return Scaffold(
      body: Center(
        child: Container(
          // padding: EdgeInsets.only(top: 200, left: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //     'You scored ${data.getScore()}\nYou can check your score in the completed section'),
              // RaisedButton(onPressed: () {
              //   Get.off(TestOverviewScreen());
              // }),
              Text(
                'Your score',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 80),
              isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    )
                  : Container(
                      // padding: EdgeInsets.only(left: 30),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                            begin: 0,
                            end: (scoredMarks / widget.maxMarks) * 2 * pi),
                        duration: Duration(seconds: 2),
                        builder:
                            (BuildContext context, double angle, Widget child) {
                          return Container(
                            child: CustomPaint(
                              size: Size(100, 100),
                              painter: MyPainter(angle: angle),
                              child: Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: Text(
                                  '$scoredMarks / ${widget.maxMarks}',
                                  style: TextStyle(fontSize: 80),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'See answers',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double angle;

  MyPainter({this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    Paint handleBarPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeJoin = StrokeJoin.bevel
      ..shader = LinearGradient(colors: [Colors.red, Colors.red])
          .createShader(Rect.fromCircle(center: Offset(50, 0), radius: 10))
      ..shader = LinearGradient(colors: [Colors.blue, Colors.blueAccent])
          .createShader(Rect.fromCircle(center: Offset(50, 0), radius: 40))
      ..strokeCap = StrokeCap.round;

    Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    // canvas.drawArc(
    //   Rect.fromCircle(
    //       center: Offset(size.width / 2, size.height / 2),
    //       radius: size.width * 1),
    //   -pi / 2,
    //   2 * pi,
    //   false,
    //   borderPaint,
    // );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width * 1 / 2),
      -pi / 2,
      angle,
      false,
      handleBarPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
