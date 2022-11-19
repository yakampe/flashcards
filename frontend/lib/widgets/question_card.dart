import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_stack.dart';

class QuestionCard extends StatefulWidget {
  final Function onPress;
  final FlashCard flashCard;
  const QuestionCard({Key? key, required this.onPress, required this.flashCard}) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  Offset offset = Offset((MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width / 2 / cardWidth + 0.5) * -1,0);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        offset = const Offset(0, 0);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      curve: Curves.easeInOutBack,
      offset: offset,
      duration: const Duration(milliseconds: 750),
      child: Card(
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(color: Colors.red),
          height: cardHeight,
          width: cardWidth,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Text('Question ${widget.flashCard.question}'),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onPress();
                  },
                  child: const Text('Show Answer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
