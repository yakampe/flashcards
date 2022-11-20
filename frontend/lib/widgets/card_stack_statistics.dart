import 'package:flutter/material.dart';

class CardStackStatistics extends StatefulWidget {
  const CardStackStatistics({Key? key}) : super(key: key);

  @override
  _CardStackStatisticsState createState() => _CardStackStatisticsState();
}

class _CardStackStatisticsState extends State<CardStackStatistics> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.red),
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Current Card:'),
                Text('0 / 22'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Correct Cards:'),
                Text('0'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Incorrect Cards:'),
                Text('12'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
