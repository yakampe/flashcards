import 'package:flutter/material.dart';
import 'package:frontend/state/card_process_state.dart';
import 'package:provider/provider.dart';

class CardStackStatistics extends StatefulWidget {
  const CardStackStatistics({Key? key}) : super(key: key);

  @override
  _CardStackStatisticsState createState() => _CardStackStatisticsState();
}

class _CardStackStatisticsState extends State<CardStackStatistics> {

  @override
  Widget build(BuildContext context) {
    int total = Provider.of<CardProcessState>(context).getTotal;
    int counter = Provider.of<CardProcessState>(context).getCounter;
    int correct = Provider.of<CardProcessState>(context).getCorrect;
    int incorrect = Provider.of<CardProcessState>(context).getIncorrect;

    return Container(
      decoration: const BoxDecoration(color: Colors.red),
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Current Card:'),
                Text('$counter / $total'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Correct Cards:'),
                Text('$correct'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Incorrect Cards:'),
                Text('$incorrect'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
