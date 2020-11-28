import 'dart:ui';

import 'package:TestGround/screens/student_side/question_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

String instructions =
    '1. Once the paper starts you won\'t be able to go back\n\n2. Attempt all questions ';

class QuestionPaperWidget extends StatelessWidget {
  final data;

  QuestionPaperWidget({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 200,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: GestureDetector(
          onTap: () {
            // Get.to(QuestionScreen());
            Get.dialog(
              AlertDialog(
                content: Container(
                  height: Get.height * 0.5,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Instructions:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(instructions)
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                    ),
                    textColor: Colors.red,
                  ),
                  FlatButton(
                    onPressed: () {
                      // Get.off(
                      //     QuestionScreen(
                      //       questionPaperKey: data['key'],
                      //       paperTime: data['timeLeft'],
                      //     ),
                      //     transition: Transition.fadeIn);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext ctx) => QuestionScreen(
                                questionPaperKey: data['key'],
                                paperTime: data['timeLeft'],
                                submitted: data['submitted'],
                                maxMarks: data['maxMarks'],
                              )));
                    },
                    child: Text('Continue'),
                    textColor: Colors.green[800],
                  ),
                ],
              ),
            );
            print('tapped');
          },
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 1,
                ),
                child: data['image'] == null
                    ? Container(
                        color: Colors.black,
                      )
                    : Image.network(
                        data['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  child: FittedBox(
                    child: Text(
                      '${data['paperTitle']}',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Max Marks: ${data['maxMarks']}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Text(
                        'Duration: ${data['duration']} min',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
