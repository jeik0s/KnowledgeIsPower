import 'dart:convert';
import 'questionStructure.dart';
import 'package:http/http.dart' as http;


class QuestionBank {

  late int _questionAmount;
  List<QuestionStructure> _questionBank = [
    QuestionStructure(category: "loading...", question: "loading...", correctAnswer: "loading...", answers: ["loading...","loading...","loading...","loading..."])
  ];
  int _questionNumber = 0;
  
  Future<bool> getResponse({required int questionAmount}) async{
    this._questionAmount = questionAmount;

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

  String getQuestionCategory() => _questionBank[_questionNumber].category;
  String getQuestionText() => _questionBank[_questionNumber].question;
  String getQuestionCorrectAnswer() => _questionBank[_questionNumber].correctAnswer;
  List<String> getQuestionAnswer() => _questionBank[_questionNumber].answers;

  bool verifyAnswer({required String userAnswer}){
    if(userAnswer == _questionBank[_questionNumber].correctAnswer)
      return true;
    else
      return false;
  }

  void nextQuestion(){
    if(_questionNumber < _questionBank.length - 1)
      _questionNumber++;

  }

}