import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_stack.dart';

class AnswerCard extends StatefulWidget {
  final Function answer;
  final FlashCard flashCard;
  const AnswerCard({Key? key, required this.answer, required this.flashCard}) : super(key: key);

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  Offset offset = const Offset(0,0);

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      curve: Curves.easeInOutBack,
      offset: offset,
      duration: const Duration(milliseconds: 750),
      child: Card(
        elevation: 20,
        child: Container(
          height: cardHeight,
          width: cardWidth,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text('Answer ${widget.flashCard.answer}'),
              ElevatedButton(
                onPressed: () {throwCardAway(true);},
                child: const Text('correct'),
              ),
              ElevatedButton(
                onPressed: () {throwCardAway(false);},
                child: const Text('incorrect'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void throwCardAway(bool isCorrect) {
    setState(() {
      offset = const Offset(2,0);
    });
    Future.delayed(const Duration(milliseconds: 500),() {
      widget.answer(isCorrect);
    });
  }
}
