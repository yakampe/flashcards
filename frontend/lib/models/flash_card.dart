class FlashCard {
  String? id;
  String? question;
  String? answer;
  List<String>? tags;
  bool? seen;
  int? correctCount;

  FlashCard({this.id, this.question, this.answer, this.tags, this.seen, this.correctCount});

  FlashCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    tags = json['tags'].cast<String>();
    seen = json['seen'];
    correctCount = json['correctCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['tags'] = tags;
    data['seen'] = seen;
    data['correctCount'] = correctCount;
    return data;
  }
}