class QuestionStructure{
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> answers;

  QuestionStructure({required this.category, required this.question, required this.correctAnswer, required this.answers});


  factory QuestionStructure.fromJson(Map<String, dynamic> json){
    return QuestionStructure(category: json['category'], question: json['question'], correctAnswer: json['correctAnswer'], answers: json['answers']);
  }

}