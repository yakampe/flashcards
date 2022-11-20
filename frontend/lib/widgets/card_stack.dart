import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/widgets/answer_card.dart';
import 'package:frontend/widgets/question_card.dart';
import 'package:http/http.dart' as http;
import '../models/flash_card.dart';

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

enum FlashCardStage { question, answerConfirmation, answerProcess, loading }

class _CardStackState extends State<CardStack> {
  List<FlashCard> flashCards = [];
  int currentCard = 0;
  FlashCardStage flashCardStage = FlashCardStage.loading;

  @override
  void initState() {
    fetchFlashCards().then((value) => {
          setState(() {
            flashCards = value;
            flashCardStage = FlashCardStage.question;
          }),
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [drawStage()],
    );
  }

  Future<List<FlashCard>> fetchFlashCards() async {
    var uri = Uri.http('localhost:8080', 'api/flashcards/tags/${widget.tag}');
    var response = await http.get(uri);

    List<dynamic> list = json.decode(response.body);

    return list.map((e) => FlashCard.fromJson(e)).toList();
  }

  Widget drawStage() {
    switch (flashCardStage) {
      case FlashCardStage.loading:
        {
          return const Text('Loading...');
        }
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
          if (flashCards[currentCard] == flashCards.last) {
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
