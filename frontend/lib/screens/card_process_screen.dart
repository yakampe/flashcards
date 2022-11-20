import 'package:flutter/material.dart';
import 'package:frontend/state/card_process_state.dart';
import 'package:frontend/widgets/card_stack.dart';
import 'package:frontend/widgets/card_stack_statistics.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar_actions.dart';

class CardProcessScreen extends StatelessWidget {
  final String tag;
  const CardProcessScreen({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CardProcessState(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarActions(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              flex: 2,
              child: CardStackStatistics(),
            ),
            Expanded(
              flex: 5,
              child: CardStack(tag: tag, count: 22),
            ),
          ],
        ),
      ),
    );
  }
}
