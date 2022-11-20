import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_stack.dart';

class AnswerCard extends StatefulWidget {
  final Function answer;
  final FlashCard flashCard;

  const AnswerCard({Key? key, required this.answer, required this.flashCard})
      : super(key: key);

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> with TickerProviderStateMixin {
  Offset offset = const Offset(0, 0);
  bool widgetCreated = true;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: rotationAnimationDuration),
      vsync: this,
    );
    _controller.forward();
    Future.delayed(const Duration(milliseconds: rotationAnimationDuration + rotationAnimationBuffer), () {
      setState(() {
        widgetCreated = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widgetCreated ? buildAnimatedFlip() : buildAnimatedSlide();
  }

  AnimatedBuilder buildAnimatedFlip() {
    return AnimatedBuilder(
      animation: _controller,
      child: buildCard(),
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform: Matrix4.rotationY(pi * (1 - _controller.value) / 2),
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
      duration: const Duration(milliseconds: 750),
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
            Text('Answer ${widget.flashCard.answer}'),
            ElevatedButton(
              onPressed: widgetCreated
                  ? null
                  : () {
                      throwCardAway(true);
                    },
              child: const Text('correct'),
            ),
            ElevatedButton(
              onPressed: widgetCreated
                  ? null
                  : () {
                      throwCardAway(false);
                    },
              child: const Text('incorrect'),
            ),
          ],
        ),
      ),
    );
  }

  void throwCardAway(bool isCorrect) {
    setState(() {
      offset = Offset(
          MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
                      .size
                      .width /
                  2 /
                  cardWidth +
              0.5,
          0);
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      widget.answer(isCorrect);
    });
  }
}
