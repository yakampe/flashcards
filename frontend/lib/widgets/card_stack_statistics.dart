import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/state/card_process_state.dart';
import 'package:provider/provider.dart';

class CardStackStatistics extends StatefulWidget {
  const CardStackStatistics({Key? key}) : super(key: key);

  @override
  _CardStackStatisticsState createState() => _CardStackStatisticsState();
}

class _CardStackStatisticsState extends State<CardStackStatistics> {

  Column buildColumnItem(FaIcon faIcon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        faIcon,
        const SizedBox(height: 10),
        buildLabel(text),
      ],
    );
  }

  Text buildLabel(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    int total = Provider
        .of<CardProcessState>(context)
        .getTotal;
    int counter = Provider
        .of<CardProcessState>(context)
        .getCounter;
    int correct = Provider
        .of<CardProcessState>(context)
        .getCorrect;
    int incorrect = Provider
        .of<CardProcessState>(context)
        .getIncorrect;

    return Container(
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildColumnItem(const FaIcon(FontAwesomeIcons.clone),'$counter / $total'),
            buildColumnItem(const FaIcon(FontAwesomeIcons.check),'$correct'),
            buildColumnItem(const FaIcon(FontAwesomeIcons.xmark),'$incorrect'),
          ],
        ),
      ),
    );
  }
}
