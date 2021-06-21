import 'package:flutter/material.dart';
import 'questionMechanism.dart';

QuestionBank questionBank = QuestionBank();


void main() {
  runApp(KnowledgeIsPower());
}


class KnowledgeIsPower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[350],
        body: SafeArea(
          child: Container(
            child: QuizArea(),
          ),
        ) ,
      ),
    );
  }
}

class QuizArea extends StatefulWidget {
  @override
  _QuizAreaState createState() => _QuizAreaState();
}

class _QuizAreaState extends State<QuizArea> {

  List<Widget> scoreBoard = [
    Icon(Icons.check, color: Colors.green,),
    Icon(Icons.close, color: Colors.red,),
  ];

 @override
  void initState() {
    questionBank.getResponse(questionAmount: 10);
    Future.delayed(const Duration(seconds: 2), (){
      setState(() {
        questionBank.nextQuestion();
      });
    });
    super.initState();
  }



  Widget answerButton({required String answer})
    => Container(
      color: Colors.grey[400],
      child: TextButton(onPressed: (){
        setState(() {
          if(questionBank.getQuestionCorrectAnswer() == answer)
            scoreBoard.add(Icon(Icons.check, color: Colors.green,),);
          else
            scoreBoard.add(Icon(Icons.close, color: Colors.red,),);
          questionBank.nextQuestion();
        });
      }, child: Text(answer,
      textAlign: TextAlign.center,)),
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[700],
              child: Center(child: Text(questionBank.getQuestionCategory(),
              style: TextStyle(fontSize: 20,color: Colors.white),)),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Center(child: Text(questionBank.getQuestionText(),
              textAlign: TextAlign.center,)),
            ),
          ),
//          GridAnswerList()
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    answerButton(answer: questionBank.getQuestionAnswer()[0]),
                    answerButton(answer: questionBank.getQuestionAnswer()[1]),
                    answerButton(answer: questionBank.getQuestionAnswer()[2]),
                    answerButton(answer: questionBank.getQuestionAnswer()[3])
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: scoreBoard,
            ),
          )
        ],
      ),
    );
  }
}
