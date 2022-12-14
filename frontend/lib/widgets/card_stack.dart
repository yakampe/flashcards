import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/state/card_process_state.dart';
import 'package:frontend/widgets/answer_card.dart';
import 'package:frontend/widgets/card_stack_between_card_stage.dart';
import 'package:frontend/widgets/question_card.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/flash_card.dart';

const double cardHeight = 250;
const double cardWidth = 350;
const int rotationAnimationDuration = 500;
const int rotationAnimationBuffer = 50;

class CardStack extends StatefulWidget {
  final String tag;
  final int cardCount;

  const CardStack({Key? key, required this.tag, required this.cardCount})
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
          Provider.of<CardProcessState>(context, listen: false)
              .setTotal(value.length),
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
      children: [drawStage()],
    );
  }

  Future<List<FlashCard>> fetchFlashCards() async {
    var uri = Uri.http(
        'localhost:8080', 'api/flashcards/tags/${widget.tag}', {"count": widget.cardCount.toString()});
    var response = await http.get(uri);

    List<dynamic> list = json.decode(response.body);

    return list.map((e) => FlashCard.fromJson(e)).toList();
  }

  Future<void> saveFlashCardStats(
      FlashCard flashCard, bool isCorrect) async {
    var uri = Uri.http('localhost:8080', 'api/processCard',
        {"correct": isCorrect ? "true" : "false"});
    await http.put(uri, body: json.encode(flashCard.toJson()),headers: {"Content-Type":"application/json"});
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
          return CardStackBetweenCardStage(
              action: processCard,
              isEnd: flashCards[currentCard] == flashCards.last);
        }
    }
  }

  void showAnswer() {
    setState(() {
      flashCardStage = FlashCardStage.answerConfirmation;
    });
  }

  void confirmAnswer(FlashCard flashCard, bool isCorrect) {
    saveFlashCardStats(flashCard, isCorrect);
    setState(() {
      isCorrect
          ? Provider.of<CardProcessState>(context, listen: false)
              .incrementCorrectCounter()
          : Provider.of<CardProcessState>(context, listen: false)
              .incrementIncorrectCounter();
      flashCardStage = FlashCardStage.answerProcess;
    });
  }

  void processCard() {
    setState(() {
      flashCardStage = FlashCardStage.question;
      currentCard += 1;
      Provider.of<CardProcessState>(context, listen: false).incrementCounter();
    });
  }
}
