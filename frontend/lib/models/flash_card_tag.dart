class FlashCardTag {
  String? tag;
  int? count;
  int? correctCount;
  int? incorrectCount;
  int? cardsSeenCount;
  int? uniqueCardsSeenCount;


  FlashCardTag({this.tag, this.count, this.correctCount, this.incorrectCount,
      required this.cardsSeenCount, this.uniqueCardsSeenCount});

  FlashCardTag.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    count = json['count'];
    correctCount = json['correctCount'];
    incorrectCount = json['incorrectCount'];
    cardsSeenCount = json['cardsSeenCount'];
    uniqueCardsSeenCount = json['uniqueCardsSeenCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tag'] = tag;
    data['count'] = count;
    data['correctCount'] = correctCount;
    data['incorrectCount'] = incorrectCount;
    data['cardsSeenCount'] = cardsSeenCount;
    data['uniqueCardsSeenCount'] = uniqueCardsSeenCount;
    return data;
  }
}