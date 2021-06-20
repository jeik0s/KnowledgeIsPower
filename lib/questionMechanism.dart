import 'dart:convert';

import 'questionStructure.dart';
import 'package:http/http.dart' as http;


class QuestionBank {

  late int _questionAmount;
  List<QuestionStructure> _questionBank = [];
  int _questionNumber = 0;
  
  Future<bool> _getResponse() async{
    final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple'));
    if(response.statusCode == 200) {
      for(int i=0;i<_questionAmount-1;i++) {
        _questionBank.add(QuestionStructure(
          category:       jsonDecode(response.body)['results'][i]['category'],
          question:       jsonDecode(response.body)['results'][i]['question'],
          correctAnswer:  jsonDecode(response.body)['results'][i]['correct_answer'],
          answers: [
                          jsonDecode(response.body)['results'][i]['correct_answer'],
                          jsonDecode(response.body)['results'][i]['incorrect_answers'][0],
                          jsonDecode(response.body)['results'][i]['incorrect_answers'][1],
                          jsonDecode(response.body)['results'][i]['incorrect_answers'][2]
          ]
        ));
      }
      return true;
    } else {
      return false;
    }
  }

  QuestionBank({required questionAmount}){
    this._questionAmount = questionAmount;
    _getResponse();
  }

  String getQuestionCategory() => _questionBank[_questionNumber].category;
  String getQuestionText() => _questionBank[_questionNumber].question;
  String getQuestionCorrectAnswer() => _questionBank[_questionNumber].correctAnswer;
  List<String> getQuestionAnswer() => _questionBank[_questionNumber].answers;

}