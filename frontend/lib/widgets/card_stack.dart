import 'package:flutter/material.dart';
import 'package:frontend/widgets/answer_card.dart';
import 'package:frontend/widgets/question_card.dart';

const double cardHeight = 250;
const double cardWidth = 350;
const int rotationAnimationDuration = 500;
const int rotationAnimationBuffer = 50;

class CardStack extends StatefulWidget {
  final String tag;
  final int count;

  const CardStack({Key? key, required this.tag, required this.count})
      : super(key: key);

  @override
  _CardStackState createState() => _CardStackState();
}

class FlashCard {
  String question;
  String answer;
  bool? answeredCorrectly;

  FlashCard(this.question, this.answer, [this.answeredCorrectly = false]);
}

enum FlashCardStage { question, answerConfirmation, answerProcess }

class _CardStackState extends State<CardStack> {
  List<FlashCard> flashCards = getFlashCards();
  int currentCard = 0;
  FlashCardStage flashCardStage = FlashCardStage.question;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        drawStage()
      ],
    );
  }

  static List<FlashCard> getFlashCards() {
    return List.generate(2, (index) => FlashCard("q$index", "a$index"));
  }

  Widget drawStage() {
    switch (flashCardStage) {
      case FlashCardStage.question:
        {
          return QuestionCard(
              flashCard: flashCards[currentCard], onPress: showAnswer);
        }
      case FlashCardStage.answerConfirmation:
        {
          return AnswerCard(
              answer: confirmAnswer, flashCard: flashCards[currentCard]);
        }
      case FlashCardStage.answerProcess:
        {
          if(flashCards[currentCard] == flashCards.last) {
            return const Text('End');
          }
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  processCard();
                },
                child: const Text('Next Card'),
              )
            ],
          );
        }
    }
  }

  void showAnswer() {
    setState(() {
      flashCardStage = FlashCardStage.answerConfirmation;
    });
  }

  void confirmAnswer(bool isCorrect) {
    setState(() {
      flashCardStage = FlashCardStage.answerProcess;
    });
  }

  void processCard() {
    setState(() {
      flashCardStage = FlashCardStage.question;
      currentCard += 1;
    });
  }
}
