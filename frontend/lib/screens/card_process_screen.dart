import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_stack.dart';

import '../widgets/app_bar_actions.dart';
class CardProcessScreen extends StatelessWidget {
  final String tag;
  const CardProcessScreen({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarActions(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: Container(
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
            ),
          ),
          Expanded(
            flex: 5,
            child: CardStack(tag: tag, count: 22),
          ),
        ],
      ),
    );
  }
}
