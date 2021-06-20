import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Center(child: Text("First question")),
            ),
          ),
//          GridAnswerList()
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    Container(
                      color: Colors.grey[400],
                      child: TextButton(onPressed: (){}, child: Text("Answer 1")),
                    ),
                    Container(
                      color: Colors.grey[400],
                      child: TextButton(onPressed: (){}, child: Text("Answer 2")),
                    ),
                    Container(
                      color: Colors.grey[400],
                      child: TextButton(onPressed: (){}, child: Text("Answer 3")),
                    ),
                    Container(
                      color: Colors.grey[400],
                      child: TextButton(onPressed: (){}, child: Text("Answer 4")),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
