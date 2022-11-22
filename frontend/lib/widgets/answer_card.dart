import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/widgets/card_stack.dart';

import '../models/flash_card.dart';

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
    Future.delayed(
        const Duration(
            milliseconds: rotationAnimationDuration + rotationAnimationBuffer),
        () {
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
            Expanded(
              flex: 1,
              child: Transform.translate(
                offset: const Offset(20, -15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FaIcon(FontAwesomeIcons.penToSquare),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: SizedBox(
                width: double.infinity,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: RichText(
                      textAlign: TextAlign.center,
                      softWrap: true,
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          text: '${widget.flashCard.answer}'),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      primary: Colors.green, // Background color
                    ),
                    onPressed: widgetCreated
                        ? null
                        : () {
                            throwCardAway(widget.flashCard, true);
                          },
                    child: const Icon(Icons.check),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      primary: Colors.red, // Background color
                    ),
                    onPressed: widgetCreated
                        ? null
                        : () {
                            throwCardAway(widget.flashCard, false);
                          },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void throwCardAway(FlashCard flashCard, bool isCorrect) {
    setState(() {
      offset = Offset(
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width /
                  2 /
                  cardWidth +
              0.5,
          0);
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      widget.answer(flashCard, isCorrect);
    });
  }
}
