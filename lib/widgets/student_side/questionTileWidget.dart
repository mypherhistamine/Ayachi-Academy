import 'package:TestGround/models/student_side/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionTileWidget extends StatefulWidget {
  final String questionTitle;
  final index;
  final bool ansDeclared;
  final Map<String, dynamic> dummy;
  const QuestionTileWidget(
      {this.questionTitle, this.index, this.ansDeclared, this.dummy});

  @override
  _QuestionTileWidgetState createState() => _QuestionTileWidgetState();
}

class _QuestionTileWidgetState extends State<QuestionTileWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuestionPaper>(context, listen: true);
    return isLoading
        ? CircularProgressIndicator()
        : Container(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, top: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 300,
                          child: Text(
                            'Q${widget.index + 1}. ${widget.questionTitle}',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: widget.ansDeclared
                              ? Text(
                                  '${data.displayCorrectAnswerText(widget.index)}')
                              : null,
                        )
                      ],
                    ),
                  ),
                  //code error
                  for (int i = 0; i<4; i++)
                    QuestionOptions(
                      isDeclared: widget.ansDeclared,
                      optionTitle: data.listOfOptions(
                        widget.index,
                      )[i],
                      ascii: i,
                      data: data,
                      // answerColor: data.displayCorrectAnswer(widget.index, i), giving error
                      trailingItem: widget.ansDeclared
                          ? data.displayCorrectAnswerIcon(
                              widget.index,
                              i,
                            )
                          : null,
                      isTapped: data.getOptionTapState(widget.index, i),
                      tapTheQuestion: widget.ansDeclared
                          ? null
                          : () {
                              data.onOptionTapped(widget.index, i);
                              data.getOptionTapState(widget.index, i);
                              data.hasAnswered();
                            },
                    ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          );
  }
}

class QuestionOptions extends StatelessWidget {
  final optionTitle;
  final int ascii;
  final data;
  final isTapped;
  final isDeclared;
  final trailingItem;
  final Color answerColor;
  final Function showCorrectAnswers;
  final Function tapTheQuestion;
  const QuestionOptions(
      {this.optionTitle,
      this.ascii,
      this.data,
      this.isTapped,
      this.tapTheQuestion,
      this.isDeclared,
      this.showCorrectAnswers,
      this.answerColor,
      this.trailingItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [Colors.cyan,Colors.blue]
          // ),
          color: !isDeclared
              ? isTapped
                  ? Colors.cyan[200]
                  : null
              : answerColor,
          borderRadius: BorderRadius.circular(40)),
      child: ListTile(
        // tileColor: !isDeclared
        //     ? isTapped
        //         ? Colors.cyan[200]
        //         : null
        //     : answerColor,
        onTap: tapTheQuestion,
        shape: StadiumBorder(),
        leading: CircleAvatar(
          backgroundColor: !isDeclared
              ? isTapped
                  ? Colors.blue
                  : Colors.white
              : Colors.grey[200],
          child: Text(String.fromCharCode(65 + ascii)),
        ),
        title: Text('$optionTitle'),
        trailing: trailingItem,
      ),
    );
  }
}
