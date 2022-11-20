import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_stack.dart';
import 'package:frontend/widgets/tag_selector.dart';

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
      body: Center(
        child: CardStack(tag: tag, count: 22),
      ),
    );
  }
}

