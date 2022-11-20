import 'package:flutter/material.dart';
import 'package:frontend/screens/tag_selector_screen.dart';

class CardStackBetweenCardStage extends StatefulWidget {
  final Function action;
  final bool isEnd;

  const CardStackBetweenCardStage(
      {Key? key, required this.isEnd, required this.action})
      : super(key: key);

  @override
  State<CardStackBetweenCardStage> createState() => _CardStackBetweenCardStageState();
}

class _CardStackBetweenCardStageState extends State<CardStackBetweenCardStage> {
  @override
  Widget build(BuildContext context) {
    return widget.isEnd ? buildEndStage() : buildBetweenStage();
  }

  Widget buildEndStage() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20)
      ),
      onPressed: () {closePageStack();},
      child: const Icon(Icons.arrow_back),
    );
  }

  Widget buildBetweenStage() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20)
      ),
      onPressed: () {widget.action();},
      child: const Icon(Icons.arrow_forward),
    );
  }

  void closePageStack() {
    Future.delayed(const Duration(milliseconds: 250), () {
      Navigator.pop(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => const TagSelectorScreen()),
      );
    });
  }
}
