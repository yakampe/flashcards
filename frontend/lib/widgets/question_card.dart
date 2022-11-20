import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_stack.dart';

import '../models/flash_card.dart';

class QuestionCard extends StatefulWidget {
  final Function onPress;
  final FlashCard flashCard;

  const QuestionCard({Key? key, required this.onPress, required this.flashCard})
      : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard>
    with TickerProviderStateMixin {
  Offset offset = Offset(
      (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width /
                  2 /
                  cardWidth +
              0.5) *
          -1,
      0);

  bool isDestroyed = false;
  late AnimationController _controller;
  double value = 0;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: rotationAnimationDuration),
      vsync: this,
    );
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        offset = const Offset(0, 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDestroyed ? buildAnimatedFlip() : buildAnimatedSlide();
  }

  AnimatedBuilder buildAnimatedFlip() {
    return AnimatedBuilder(
      animation: _controller,
      child: buildCard(),
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform: Matrix4.rotationY(_controller.value * pi / 2),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }

  AnimatedSlide buildAnimatedSlide() {
    return AnimatedSlide(
      curve: Curves.easeInOutBack,
      offset: offset,
      duration: const Duration(milliseconds: 500),
      child: buildCard(),
    );
  }

  Card buildCard() {
    return Card(
      elevation: 20,
      child: Container(
        height: cardHeight,
        width: cardWidth,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: RichText(
                      textAlign: TextAlign.center,
                      softWrap: true,
                      text:
                          TextSpan(text: 'Question ${widget.flashCard.question}'),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: isDestroyed
                      ? null
                      : () {
                          showAnswer();
                        },
                  child: const Icon(Icons.rotate_left_sharp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAnswer() {
    setState(() {
      isDestroyed = true;
      _controller.forward();
    });
    Future.delayed(
        const Duration(
            milliseconds: rotationAnimationDuration + rotationAnimationBuffer),
        () {
      widget.onPress();
    });
  }
}
