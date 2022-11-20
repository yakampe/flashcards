class FlashCard {
  String? id;
  String? question;
  String? answer;
  List<String>? tags;

  FlashCard({this.id, this.question, this.answer, this.tags});

  FlashCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['tags'] = tags;
    return data;
  }
}