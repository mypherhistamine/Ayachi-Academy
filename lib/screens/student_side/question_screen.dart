import 'package:TestGround/models/student_side/question.dart';
import 'package:TestGround/models/themeconsts.dart';
import 'package:TestGround/screens/student_side/score_screen.dart';
import 'package:TestGround/screens/student_side/test_overview_screen.dart';

import 'package:TestGround/widgets/student_side/questionTileWidget.dart';
import 'package:TestGround/widgets/student_side/timerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatefulWidget {
  final questionPaperKey;
  final paperTime;
  final submitted;
  final maxMarks;
  static const routeName = 'questionScreen';

  const QuestionScreen(
      {Key key,
      this.questionPaperKey,
      this.paperTime,
      this.submitted,
      this.maxMarks})
      : super(key: key);
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool reveal = false;
  bool ansDeclared = false;
  bool isLoading = false;
  int score = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isLoading = true;
      });
      final data = Provider.of<QuestionPaper>(context, listen: false);
      await data.getQuestionPaperLength(qpaperKey: widget.questionPaperKey);
      score = await data.getScoreFromDB(paperKey: widget.questionPaperKey);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuestionPaper>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        // backgroundColor: ThemeConstants().blueColor,
        elevation: 10,
        title: widget.submitted
            ? isLoading
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Score: $score'),
                  )
            : Text(
                'Time Left : ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
        automaticallyImplyLeading: false,
        actions: [
          widget.submitted
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Go back',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TimerWidget(
                    fetchTime: widget.paperTime,
                    paperKey: widget.questionPaperKey,
                  ),
                )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: size.height,
              // margin: EdgeInsets.only(bottom: 10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                key: GlobalKey(),
                children: [
                  Expanded(
                    // width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (ctx, i) {
                        return Column(
                          children: [
                            QuestionTileWidget(
                              questionTitle: data.allTitles()[i],
                              index: i,
                              ansDeclared: widget.submitted,
                            ),
                            // QuestionWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            if (i == data.getQuestionCount() - 1)
                              widget.submitted
                                  ? SizedBox()
                                  : Container(
                                      height: 60,
                                      width: double.infinity,
                                      // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                                      margin: EdgeInsets.only(
                                          bottom: 20,
                                          left: 15,
                                          right: 15,
                                          top: 10),
                                      child: RaisedButton(
                                        color: Color(0xff27282A),
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.cyan, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        onPressed: () async {
                                          // setState(() {
                                          //   ansDeclared = !ansDeclared;
                                          // });
                                          data.getScore();
                                          data.submitScore(
                                              paperKey:
                                                  widget.questionPaperKey);
                                          // data.printAll();
                                          data.submitToDatabase(
                                              paperKey:
                                                  widget.questionPaperKey);
                                          // data.getMaxMarksfromDB(
                                          //     paperKey: widget.questionPaperKey);
                                          Get.off(ScoreScreen(
                                              maxMarks: widget.maxMarks,
                                              paperKey:
                                                  widget.questionPaperKey));
                                        },
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              color: Colors.cyan, fontSize: 20),
                                        ),
                                      ),
                                    ),
                          ],
                        );
                      },
                      itemCount: 6,
                    ),
                  ),

                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     // RaisedButton(
                  //     //   onPressed: () {
                  //     //     data.hasAnswered();
                  //     //     data.printAll();
                  //     //   },
                  //     //   child: Text('Checker'),
                  //     // ),
                  //     // RaisedButton(
                  //     //   onPressed: () {
                  //     //     data.onSubmit();
                  //     //   },
                  //     //   child: Text('Clear'),
                  //     // ),
                  //     // RaisedButton(
                  //     //   onPressed: () {
                  //     //     setState(() {
                  //     //       ansDeclared = !ansDeclared;
                  //     //     });
                  //     //     data.getScore();

                  //     //     // data.printAll();
                  //     //     data.submitToDatabase(
                  //     //         paperKey: widget.questionPaperKey);
                  //     //   },
                  //     //   child: Text('Submit'),
                  //     // ),
                  //     // RaisedButton(
                  //     //   onPressed: () {
                  //     //     setState(() {
                  //     //       ansDeclared = !ansDeclared;
                  //     //     });
                  //     //     data.getFromDatabse();
                  //     //   },
                  //     //   child: Text('Get from DB'),
                  //     // ),
                  //     // SizedBox(
                  //     //   height: 10,
                  //     // ),
                  //     // RaisedButton(
                  //     //   onPressed: () {
                  //     //     setState(() {
                  //     //       ansDeclared = !ansDeclared;
                  //     //     });
                  //     //     data.getScore();

                  //     //     // data.printAll();
                  //     //     data.submitToDatabase(
                  //     //         paperKey: widget.questionPaperKey);
                  //     //   },
                  //     //   child: Text('Submit'),
                  //     // ),
                  //     // RaisedButton(
                  //     //   onPressed: () async {
                  //     //     data.getQuestionPaperForSpecificUser(
                  //     //         userId: '4O9ZNFOoNvNuIp0y0wpynzQbWJy2');
                  //     //     data.submitScore(paperKey: widget.questionPaperKey);
                  //     //   },
                  //     //   child: Text('Tester'),
                  //     // ),

                  //     // if (ansDeclared) Text('Score is: ${data.getScore()} ')
                  //   ],
                  // )
                ],
              ),
            ),
    );
  }
}
