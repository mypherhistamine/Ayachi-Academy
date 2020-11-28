import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  getQuestionPapers();
  // getQuestionPaperForSpecificUser();
}

Future<List> getQuestionPapers() async {
  List random = [];
  List listOfQuestionKeys = [];

  final tester = 'https://ayachi-academy.firebaseio.com/questionPapers/.json';

  final url =
      'https://ayachi-academy.firebaseio.com/users/4O9ZNFOoNvNuIp0y0wpynzQbWJy2/assigned.json';

  final response = await http.get(url);
  listOfQuestionKeys = json.decode(response.body);
  for (int i = 0; i < listOfQuestionKeys.length; i++) {
    var data =
        'https://ayachi-academy.firebaseio.com/questionPapers/${listOfQuestionKeys[i]}.json';
    var response2 = await http.get(data);
    random.add(json.decode(response2.body));
  }
  print(random);
  return random;
}

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
//   print(random);
//   return random;
// }

Future<void> getQuestionPaperForSpecificUser({userId}) async {}
