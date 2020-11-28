// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

var tester = {};



QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
    QuestionModel({
        this.questionPapers,
        this.users,
    });

    Map<String, QuestionPaper2> questionPapers;
    Map<String, User> users;

    factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        questionPapers: Map.from(json["questionPapers"]).map((k, v) => MapEntry<String, QuestionPaper2>(k, QuestionPaper2.fromJson(v))),
        users: Map.from(json["users"]).map((k, v) => MapEntry<String, User>(k, User.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "questionPapers": Map.from(questionPapers).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "users": Map.from(users).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class QuestionPaper2 {
    QuestionPaper2({
        this.duration,
        this.maxMarks,
        this.paperTitle,
        this.questions,
    });

    int duration;
    int maxMarks;
    String paperTitle;
    List<Question> questions;

    factory QuestionPaper2.fromJson(Map<String, dynamic> json) => QuestionPaper2(
        duration: json["duration"],
        maxMarks: json["maxMarks"],
        paperTitle: json["paperTitle"],
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "duration": duration,
        "maxMarks": maxMarks,
        "paperTitle": paperTitle,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}


class Question {
    Question({
        this.hasAnswered,
        this.options,
        this.title,
    });

    bool hasAnswered;
    List<List<dynamic>> options;
    String title;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        hasAnswered: json["hasAnswered"],
        options: List<List<dynamic>>.from(json["options"].map((x) => x == null ? null : List<dynamic>.from(x.map((x) => x)))),
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "hasAnswered": hasAnswered,
        "options": List<dynamic>.from(options.map((x) => x == null ? null : List<dynamic>.from(x.map((x) => x)))),
        "title": title,
    };
}

class User {
    User({
        this.assigned,
        this.classNumber,
        this.completed,
        this.emailId,
        this.firstName,
        this.lastName,
        this.role,
        this.userName,
    });

    List<String> assigned;
    String classNumber;
    List<String> completed;
    String emailId;
    String firstName;
    String lastName;
    String role;
    String userName;

    factory User.fromJson(Map<String, dynamic> json) => User(
        assigned: List<String>.from(json["assigned"].map((x) => x)),
        classNumber: json["classNumber"],
        completed: List<String>.from(json["completed"].map((x) => x)),
        emailId: json["emailId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "assigned": List<dynamic>.from(assigned.map((x) => x)),
        "classNumber": classNumber,
        "completed": List<dynamic>.from(completed.map((x) => x)),
        "emailId": emailId,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "userName": userName,
    };
}
