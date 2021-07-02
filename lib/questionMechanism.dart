import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';
import 'questionStructure.dart';
import 'package:http/http.dart' as http;


class QuestionBank {

  int _correctAnswers = 0;

  late int _questionAmount;
  List<QuestionStructure> _questionBank = [
    QuestionStructure(category: "loading...", question: "loading...", correctAnswer: "loading...", answers: ["loading...","loading...","loading...","loading..."])
  ];
  int _questionNumber = 0;
  
  Future<bool> getResponse({required int questionAmount}) async{
    this._questionAmount = questionAmount;

    final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple'));
    if(response.statusCode == 200) {
      for(int i=0;i<_questionAmount;i++) {
        _questionBank.add(QuestionStructure(
          category:       HtmlUnescape().convert(jsonDecode(response.body)['results'][i]['category']),
          question:       HtmlUnescape().convert(jsonDecode(response.body)['results'][i]['question']),
          correctAnswer:  HtmlUnescape().convert(jsonDecode(response.body)['results'][i]['correct_answer']),
          answers: [
                          HtmlUnescape().convert(jsonDecode(response.body)['results'][i]['correct_answer']),
                          HtmlUnescape().convert(jsonDecode(response.body)['results'][i]['incorrect_answers'][0]),
                          HtmlUnescape().convert(jsonDecode(response.body)['results'][i]['incorrect_answers'][1]),
                          HtmlUnescape().convert(jsonDecode(response.body)['results'][i]['incorrect_answers'][2])
          ]
        ));
        (_questionBank[i].answers).shuffle();
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

  void increaseGoodNumberValue(){
    _correctAnswers++;
  }

int getCorrectAnswers(){
    return _correctAnswers;
}

  bool lastQuestion(){
    if(_questionNumber == _questionBank.length - 1)
      return true;
    else
      return false;
  }

  void nextQuestion(){
    if(_questionNumber < _questionBank.length - 1)
      _questionNumber++;
  }

  restartPoll(){
    _questionNumber=0;
    _correctAnswers=0;
    _questionBank.clear();
    _questionBank.add(QuestionStructure(category: "loading...", question: "loading...", correctAnswer: "loading...", answers: ["loading...","loading...","loading...","loading..."]));
    getResponse(questionAmount: 10);
  }

}