class QuestionsModel {
  List<QuestionsItem> listQuestions = [];
  QuestionsModel.fromJson(List<dynamic> list) {
    for (var element in list) {
      listQuestions.shuffle();
      listQuestions.add(QuestionsItem.fromJson(element));
    }
  }
}

class QuestionsItem {
  late String question;
  late String a;
  late String b;
  late String c;
  late String d;
  late String correct;

  QuestionsItem.fromJson(Map<String, dynamic> json) {
    question = json['Question'];
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
    correct = json['correct'];
  }
}
