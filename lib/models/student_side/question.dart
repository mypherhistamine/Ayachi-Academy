import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionPaper with ChangeNotifier {
  //like this false - option selected , another false or true is whether the question is right or wrong

  // Map<String, dynamic> dummy = {
  //   "duration": 45,
  //   "maxMarks": 30,
  //   "paperTitle": "CS Quiz",
  //   "questions": [
  //     {
  //       "hasAnswered": true,
  //       "options": [
  //         null,
  //         ["15m", 0, false, false],
  //         ["6m", 0, true, false],
  //         ["12m", 1, false, true],
  //         ["8.75m", 0, false, false]
  //       ],
  //       "title": "The perimeter of a rectangle of length 3.5 m and  is"
  //     },
  //     {
  //       "hasAnswered": true,
  //       "options": [
  //         null,
  //         ["12m", 0, false, false],
  //         ["15m", 0, false, false],
  //         ["6m", 0, true, false],
  //         ["88m", 1, false, true]
  //       ],
  //       "title":
  //           "The circumference of a circle of diameter 28mm is ( take π = 22/7 )"
  //     },
  //     {
  //       "hasAnswered": true,
  //       "options": [
  //         null,
  //         ["616cm²", 0, true, false],
  //         ["44cm²", 0, false, false],
  //         ["462cm²", 1, false, true],
  //         ["none of these", 0, false, false]
  //       ],
  //       "title":
  //           "The area of the shaded region is : Given OA = 7cm , OB = 14cm ( π = 22/7)"
  //     },
  //     {
  //       "hasAnswered": true,
  //       "options": [
  //         null,
  //         ["6cm²", 0, false, false],
  //         ["12cm²", 1, false, true],
  //         ["18cm²", 0, true, false],
  //         ["none of these", 0, false, false]
  //       ],
  //       "title": "The area of the triangle shown here is "
  //     },
  //     {
  //       "hasAnswered": true,
  //       "options": [
  //         null,
  //         ["40cm²", 0, false, false],
  //         ["30cm²", 1, true, true],
  //         ["15cm²", 0, false, false],
  //         ["5cm²", 0, false, false]
  //       ],
  //       "title":
  //           "The area of a parallelogram whose base is 12cm and corresponding altitude is 2.5cm is "
  //     },
  //   ]
  // };

  Map<String, dynamic> dummy = {};

  List<String> titles = [];
  int globalScore = 0;

  //done
  int optionsCount(int i) {
    int count = 0;
    if (dummy != null) {
      Map<String, dynamic> random2 = dummy;
      random2.forEach((key, value) {
        if (key == 'questions') {
          value[i]['options'].forEach((value) {
            count++;
          });
        }
      });
    }
    print(count);
    count = count - 1;
    return count;
  }

  //done
  List<String> allTitles() {
    if (dummy != null) {
      List questionTitles = dummy['questions'];
      questionTitles.forEach((element) {
        titles.add(element['title']);
      });
    }
    return titles;
  }

  //done
  int getQuestionCount() {
    int index = 0;
    if (dummy != null) {
      List questionList = dummy["questions"];

      questionList.forEach((element) {
        index++;
      });
    }
    // print(index);
    return index;
  }

  //done
  List listOfOptions(int i) {
    List options = [];
    if (dummy != null) {
      var mappedOptions = dummy['questions'][i]['options'];
      mappedOptions.forEach((value) {
        if (value != null) {
          options.add(value[0]);
        }
      });
    }
    return options;
  }

  //done
  int getScore() {
    int score = 0;
    if (dummy != null) {
      dummy['questions'].forEach((element) {
        element['options'].forEach((value) {
          if (value != null) {
            if (value[2] == true) {
              score = value[1] + score;
            }
          }
        });
      });
    }
    globalScore = score;
    // print(score);
    notifyListeners();
    return score;
  }

  int get fetchScore {
    return globalScore;
  }

  //done
  String displayCorrectAnswerText(int index) {
    var temp;
    var indexer = 0;
    if (dummy != null) {
      List fixedList = List(dummy['questions'].length);

      dummy['questions'].forEach((element) {
        element['options'].forEach((value) {
          if (value != null) {
            if (value[2] == !value[3] && value[2] == true) {
              //wrong option
              fixedList[indexer] = '0/1';
            } else if (value[3] == true && value[2] == true) {
              //correct option
              fixedList[indexer] = '1/1';
            } else if (value[3] == true && value[2] == false) {
              fixedList[indexer] = '0/ 1';
            }
          }
        });
        indexer++;
      });
      return fixedList[index];
    }
  }

  //done
  bool hasAnswered({int indexFunc}) {
    if (dummy != null) {
      List random = dummy['questions'];
      bool temp = false;
      int index = 0;

      random.forEach((element) {
        index++;
        // print(index);
        for (int j = 0; j < random[index - 1]['options'].length; j++) {
          // print(random[index - 1]['options']['${j + 1}']);
          if (random[index - 1]['options'][j + 1][2] == true) {
            temp = true;
            dummy['questions'][index - 1]['hasAnswered'] = temp;
            break;
          }
          dummy['questions'][index - 1]['hasAnswered'] = false;
        }
        // print(questions['questions'][index - 1]['hasAnswered']);
        // print('------');
        return dummy['questions'][index - 1]['hasAnswered'];
      });
      // print(index);
      return dummy['questions'][indexFunc]['hasAnswered'];
    }
  }

  //done
  Color displayCorrectAnswer(
    int index,
    int optionIndex,
  ) {
    if (dummy != null) {
      var value = dummy['questions'][index]['options'][optionIndex + 1];
      if (hasAnswered(indexFunc: index)) {
        // print('Selected ${value[2]} correct  : ${value[3]}');
        if (value[2] == !value[3] && value[2] == true) {
          return Colors.red[100];
        } else if (value[3] == true) {
          return Colors.green[100];
        }
      }
    }
  }

  //done
  // ignore: missing_return
  Widget displayCorrectAnswerIcon(
    int index,
    int optionIndex,
  ) {
    if (dummy != null) {
      var value = dummy['questions'][index]['options'][optionIndex + 1];

      // print('Selected ${value[2]} correct  : ${value[3]}');
      if (value[2] == !value[3] && value[2] == true) {
        return Icon(
          Icons.clear,
          color: Colors.red,
        );
      } else if (value[3] == true) {
        return Icon(
          Icons.check,
          color: Colors.green,
        );
      }
    }
  }

  //done
  bool getOptionTapState(
    int index,
    int optionIndex,
  ) {
    if (dummy != null) {
      // print('index : $index , optionIndex : $optionIndex');
      var random = dummy['questions'][index]['options'][optionIndex + 1][2];
      // print(random);

      return random;
    }
  }

  //done
  void onOptionTapped(int index, int optionIndex) {
    if (dummy != null) {
      for (int i = 0; i < optionsCount(index); i++) {
        if (i == optionIndex) {
          // print(dummy['questions'][index]['options'][i + 1][2]);
          // print(optionIndex);

          try {
            dummy['questions'][index]['options'][i + 1][2] =
                !dummy['questions'][index]['options'][i + 1][2];
          } catch (err) {
            print(err);
          }
        } else {
          try {
            dummy['questions'][index]['options'][i + 1][2] = false;
          } catch (err) {
            print(err);
          }
        }
      }
      // print(dummy['questions'][index]['options']);
      notifyListeners();
    }
    // print('index $index , optionindex : $optionIndex');
  }

  void printAll() {
    print(dummy);
  }

  void onSubmit() {
    if (dummy != null) {
      for (int i = 0; i < dummy['questions'].length; i++) {
        dummy['questions'][i]['hasAnswered'] = false;
      }
    }
    notifyListeners();
  }

  void submitToDatabase({paperKey}) async {
    const url = 'https://ayachi-academy.firebaseio.com/questionPapers.json';
    final paperUrl =
        'https://ayachi-academy.firebaseio.com/questionPapers/$paperKey/questions.json';
    final tester =
        'https://ayachi-academy.firebaseio.com/questionPapers/red/.json';
    // http.post(url, body: json.encode(dummy), headers: {'user': 'Rishabh'});
    // print(dummy);
    final response =
        await http.put(paperUrl, body: json.encode(dummy['questions']));

    // print(response.statusCode);
  }

  Future<void> getFromDatabse() async {
    try {
      const url = 'https://ayachi-academy.firebaseio.com/questionPapers/.json';
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        value['questions'][0]['options'].forEach((element) {
          if (element != null) {
            // print(element);
          }
        });
      });
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Map<String, dynamic> tester = {};

  Future<Map<String, dynamic>> getQuestionPaperLength({qpaperKey}) async {
    List random = [];
    try {
      const url = 'https://ayachi-academy.firebaseio.com/questionPapers/.json';
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        if (key == '$qpaperKey') {
          random.add(value);
        }
      });
    } catch (err) {
      print(err);
    }
    // print(random.length);
    // print(random[0]);
    dummy = random[0];
    // tester = random[0];
    // print(tester);
    // print(dummy);
    notifyListeners();
    return dummy;
  }

  //for getting the listview dont touch
  // Future<List> getQuestionPapers() async {
  //   List random = [];
  //   try {
  //     const url = 'https://ayachi-academy.firebaseio.com/questionPapers/.json';
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     extractedData.forEach((key, value) {
  //       // print('value : $value');
  //       random.add(value);
  //     });
  //   } catch (err) {
  //     print(err);
  //   }

  //   return random;
  // }

  List papersList = [];

  List ultraRandom;

  List get getdata {
    notifyListeners();
    return ultraRandom;
  }

  Future<List> getQuestionPapers({userId}) async {
    List random = [];
    List listOfQuestionKeys = [];

    final tester = 'https://ayachi-academy.firebaseio.com/questionPapers/.json';

    final url =
        'https://ayachi-academy.firebaseio.com/users/$userId/assigned.json';

    final response = await http.get(url);
    listOfQuestionKeys = json.decode(response.body);
    //checks if there are question keys
    if (listOfQuestionKeys[0] == '') {
      return null;
    }
    for (int i = 0; i < listOfQuestionKeys.length; i++) {
      var data =
          'https://ayachi-academy.firebaseio.com/questionPapers/${listOfQuestionKeys[i]}.json';
      var response2 = await http.get(data);
      random.add(json.decode(response2.body));
      // ultraRandom.add(json.decode(response2.body));
    }
    notifyListeners();
    // print('ye hi hai nah ? ');
    print(random);
    return random;
  }

  Future<void> getQuestionPaperForSpecificUser({userId}) async {
    final url =
        'https://ayachi-academy.firebaseio.com/users/4O9ZNFOoNvNuIp0y0wpynzQbWJy2/assigned.json';

    final response = await http.get(url);

    // print(response.body);
  }

  Future<void> sendTimerToDB(int seconds, {paperKey}) async {
    const url = 'https://ayachi-academy.firebaseio.com/timers/Shaurya.json';
    final sendTime =
        'https://ayachi-academy.firebaseio.com/questionPapers/$paperKey/timeLeft.json';
    final sent = await http.put(sendTime, body: json.encode(seconds));

    // print(sent.statusCode);
  }

  int timeGot;

  Future<int> getTimerFromDB({timerKey}) async {
    const url = 'https://ayachi-academy.firebaseio.com/timers/Shaurya.json';
    final getTime =
        'https://ayachi-academy.firebaseio.com/questionPapers/$timerKey/timeLeft.json';
    final response = await http.get(getTime);
    // print(response.body);
    final time = json.decode(response.body);
    // print('timerUniqueRishabh: $time');
    timeGot = time;
    // print(time['timeLeft']);
    return time['timeLeft'];
  }

  Future<void> getMaxMarksfromDB({paperKey}) async {
    final url =
        'https://ayachi-academy.firebaseio.com/questionPapers/$paperKey/maxMarks.json';

    final response = await http.get(url);
    // print(response.body);
  }

  Future<int> getScoreFromDB({paperKey}) async {
    final url =
        'https://ayachi-academy.firebaseio.com/questionPapers/$paperKey/score.json';
    final response = await http.get(url);

    return int.parse(response.body);

    // print(response.body);
  }

  Future<void> submitScore({paperKey}) async {
    final url =
        'https://ayachi-academy.firebaseio.com/questionPapers/$paperKey/score.json';
    final submitted =
        'https://ayachi-academy.firebaseio.com/questionPapers/$paperKey/submitted.json';

    final response = await http.put(url, body: json.encode(globalScore));
    final submittedResponse =
        await http.put(submitted, body: json.encode(true));
  }
}
