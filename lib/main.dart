import 'package:flutter/material.dart';
import 'questionMechanism.dart';

QuestionBank questionBank = QuestionBank(questionAmount: 10);

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

  Widget answerButton({required String answer})
    => Container(
      color: Colors.grey[400],
      child: TextButton(onPressed: (){}, child: Text(answer)),
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
        ],
      ),
    );
  }
}
